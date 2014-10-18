package org.red5.server.mixer;

import java.util.HashMap;
import java.util.Map;

import org.apache.mina.core.buffer.IoBuffer;
import org.red5.logging.Red5LoggerFactory;
import org.red5.server.api.Red5;
import org.red5.server.net.rtmp.IRTMPHandler;
import org.red5.server.net.rtmp.RTMPConnManager;
import org.red5.server.net.rtmp.RTMPConnection;
import org.red5.server.net.rtmp.RTMPMinaConnection;
import org.red5.server.net.rtmp.event.AudioData;
import org.red5.server.net.rtmp.event.ChunkSize;
import org.red5.server.net.rtmp.event.Invoke;
import org.red5.server.net.rtmp.event.Notify;
import org.red5.server.net.rtmp.event.VideoData;
import org.red5.server.net.rtmp.message.Constants;
import org.red5.server.net.rtmp.message.Header;
import org.red5.server.net.rtmp.message.Packet;
import org.red5.server.service.PendingCall;
import org.red5.server.stream.IStreamData;
import org.slf4j.Logger;

import java.nio.ByteBuffer;

public class GroupMixer implements SegmentParser.Delegate, KaraokeGenerator.Delegate {

    public static final String MIXED_STREAM_PREFIX = "__mixed__";
    public static final String ALL_IN_ONE_STREAM_NAME = "allinone";
    public static final String SPECIAL_STREAM_NAME = "karaoke"; //test name
    private static final String AppName = "myRed5App";//TODO appName change to a room or something
    private static final String ipAddr = "localhost"; //TODO change to something else in the future
    private static GroupMixer instance_;
    private String allInOneSessionId_ = null; //all-in-one mixer rtmp connection
    private static Logger log = Red5LoggerFactory.getLogger(Red5.class);
    
    private IdLookup idLookupTable = new IdLookup();
    
    // Java processPipe vs. native Process pipe
    // private ProcessPipe mixerPipe_ = null;
    private NativeProcessPipe mixerPipe_ = null;
    private boolean bMixerOpenedSuccess_ = false;
    private IRTMPHandler handler_ = null;
    
    //special stream
    private KaraokeGenerator karaokeGen_ = null;
    
    private GroupMixer() {
    }
	
    public static synchronized GroupMixer getInstance() {
        if(instance_ == null) {
        	instance_ = new GroupMixer();
        }
        return instance_;
    }

    public void prepare(IRTMPHandler handler, 
    					boolean bShouldMix, 
    					boolean bSaveToDisc, String outputFilePath,
    					boolean bLoadFromDisc, String inputFilePath,
    					boolean bGenKaraoke, String karaokeFilePath)
	{ 	
    	if( handler_ == null ) {
        	handler_ = handler;
    	    //starts process pipe
    	    if( bShouldMix ) {
    	    	mixerPipe_ = new NativeProcessPipe(this, bSaveToDisc, outputFilePath, bLoadFromDisc, inputFilePath);
    	    }
    
    	    if( bGenKaraoke ) {
    	    	karaokeGen_ = new KaraokeGenerator(this, karaokeFilePath);
    	    }
    	}
    	log.info("prepare AllInOneConn!");
	}
    
    private void createAllInOneConn()
    {  
    	if( allInOneSessionId_ == null ) {
    	    // create a connection
    	    RTMPMinaConnection connAllInOne = (RTMPMinaConnection) RTMPConnManager.getInstance().createConnection(RTMPMinaConnection.class, false);
    	    // add session to the connection
    	    connAllInOne.setIoSession(null);
    	    // add the handler
    	    connAllInOne.setHandler(handler_);
    	    
    	    // set it in MixerManager
    	    allInOneSessionId_ = connAllInOne.getSessionId();
    	    
    	    //??? different thread , see mina threading model ???
    	    //next assume the session is opened
    	    handler_.connectionOpened(connAllInOne);
    	    
    	    //handle connect, createStream and publish events
    	    handleConnectEvent(connAllInOne);
    	}
	    //kick off createStream event
    	createMixedStreamInternal(ALL_IN_ONE_STREAM_NAME);
	    
	    //kick off karaoke 
	    if( karaokeGen_!= null ) {
	    	createMixedStreamInternal(SPECIAL_STREAM_NAME);
	    }
	    
	    if( mixerPipe_ != null) {
	    	bMixerOpenedSuccess_ = mixerPipe_.open(); 
	    }
	    
		//start the karaoke thread
	    if( karaokeGen_!= null ) {
    		karaokeGen_.tryToStart();
    	}
	    log.info("Created all In One connection with bMixerOpenedSuccess_={} sessionId {} on thread: {}", bMixerOpenedSuccess_, allInOneSessionId_, Thread.currentThread().getName());
    }	

	//close all-in-one RTMPConnections and all its associated assets
    private void deleteAllinOneConn()
    {
    	log.info("Deleted all In One connection with bMixerOpenedSuccess_={} sessionId {} on thread: {}", bMixerOpenedSuccess_, allInOneSessionId_, Thread.currentThread().getName());

		//stop the karaoke thread
    	if( karaokeGen_ != null ) {
    		karaokeGen_.tryToStop();
    	}
    	//close the process pipe
    	if( mixerPipe_ != null ) {
    		mixerPipe_.close();
    	}

	    //shutdown all in one stream
    	deleteMixedStreamInternal(ALL_IN_ONE_STREAM_NAME);
	    
	    //shutdown karaoke stream
	    if( karaokeGen_!= null ) {
	    	deleteMixedStreamInternal(SPECIAL_STREAM_NAME);
	    }
	    
	    //remove connection
	    RTMPConnManager.getInstance().removeConnection(allInOneSessionId_);
	    allInOneSessionId_ = null;
    }
    
    public boolean hasAnythingStarted() {
    	return !idLookupTable.isEmpty();
    }
    
    public void createMixedStream(String streamName)
    {
    	if( idLookupTable.isEmpty() ) {
    		//next creates the all-in-one RTMPMinaConnection
    		createAllInOneConn();
    	}
    	createMixedStreamInternal(streamName);
    }  

    public void deleteMixedStream(String streamName)
    {
    	if( deleteMixedStreamInternal(streamName) != -1 ) {
        	log.info("----------------after deleting stream {}, idLookupTable cnt={}", streamName, idLookupTable.getCount());
        	//if all streams are removed, remove the special stream and free up the mixer
        	boolean isEmpty = idLookupTable.isEmpty();
        	if( !isEmpty && karaokeGen_!= null ) {
        		//if there is only 1 stream, which is the special stream, also clean up everything
        		if( idLookupTable.getCount() == 1) {
        			isEmpty = true;
        		}
        	}
        	if( isEmpty ) {
        		deleteAllinOneConn();
        	}
    	}
    }
    
    private void createMixedStreamInternal(String streamName) {
    	int newStreamId = idLookupTable.createNewEntry(streamName);
    	
    	RTMPMinaConnection conn = getAllInOneConn();
    	handleCreatePublishEvents(conn, MIXED_STREAM_PREFIX+streamName, newStreamId);
    }
    
    private int deleteMixedStreamInternal(String streamName)
    {
    	log.info("----------------try to delete stream {}", streamName);
    	int streamId = idLookupTable.deleteEntry(streamName);
    	if ( streamId != -1 ) {        	
    		RTMPMinaConnection conn = getAllInOneConn();
    		handleDeleteEvent(conn, streamId);
    	}
    	return streamId;
    }
    
    public void pushInputMessage(String streamName, int msgType, IoBuffer buf, int eventTime)
    {	
    	if( buf.limit() > 0 && mixerPipe_ != null && bMixerOpenedSuccess_ ) {
    		//log.info("----------------pushInputMessage, buf.limit()={}, mixerPipe_={}, bMixerOpenedSuccess_={}", buf.limit(), mixerPipe_, bMixerOpenedSuccess_);
    		mixerPipe_.handleSegInput(idLookupTable, streamName, msgType, buf, eventTime);
    	}
    }

    public void onFrameParsed(int mixerId, ByteBuffer frame, int flvFrameLen)
    {
    	int streamId = idLookupTable.lookupStreamId(mixerId);
    	//log.info("=====>onFrameParsed mixerId {} len {} streamName {}", mixerId, flvFrameLen, idLookupTable.lookupStreamName(mixerId) );
    	onFrameGenerated( streamId, frame, flvFrameLen, false );
    }
    
    private void onFrameGenerated( int streamId, ByteBuffer frame, int flvFrameLen, boolean isKaraoke) {	
    	if ( streamId != -1 ) {
	    byte[] flvFrame = frame.array();
	    int curIndex = 0;
	    if(flvFrame[0] =='F' && flvFrame[1]=='L' && flvFrame[2] == 'V') {
	    	curIndex+=13;
	    }        		
	    while( curIndex < flvFrameLen ) {
		int msgType = flvFrame[curIndex];
            	int msgSize = ((((int)flvFrame[curIndex+1])&0xff)<<16) | ((((int)flvFrame[curIndex+2])&0xff)<<8) | ((int)(flvFrame[curIndex+3])&0xff);
            	int msgTimestamp = ((((int)flvFrame[curIndex+4])&0xff)<<16) | ((((int)flvFrame[curIndex+5])&0xff)<<8) | ((int)(flvFrame[curIndex+6])&0xff) | ((((int)flvFrame[curIndex+7])&0xff)<<24);
		//log.info("=====>out message from {} 1stByte {} msgType {} curIndex={} flvFrameLen={} msgSize {} ts {} on thread: {}", streamId, flvFrame[curIndex+11], msgType, curIndex, flvFrameLen, msgSize, msgTimestamp, Thread.currentThread().getName());
		curIndex += 11;
        	
		//RTMP Chunk Header
		Header msgHeader = new Header();
		msgHeader.setDataType((byte)msgType);//invoke is command, val=20
		msgHeader.setChannelId(3); //channel TODO does it really matter since we consume it internally.
		// see RTMPProtocolDecoder::decodePacket() 
		// final int readAmount = (readRemaining > chunkSize) ? chunkSize : readRemaining;
		msgHeader.setSize(msgSize);   //Chunk Data Length, a big enough buffersize
		msgHeader.setStreamId(streamId);  //streamid
		msgHeader.setTimerBase(0); //base+delta=timestamp
		msgHeader.setTimerDelta(msgTimestamp);
		msgHeader.setExtendedTimestamp(0); //extended timestamp
        		
        RTMPMinaConnection conn = getAllInOneConn();
        switch(msgType) {
		case Constants.TYPE_AUDIO_DATA:
		    {
			AudioData msgEvent = new AudioData();
			msgEvent.setHeader(msgHeader);
			msgEvent.setTimestamp(msgTimestamp);
			msgEvent.setDataRemaining(flvFrame, curIndex, msgSize);   
			msgEvent.setSourceType(Constants.SOURCE_TYPE_LIVE);
            		
			//send karaoke to mixer directly
			if( isKaraoke ) {
			    IoBuffer buf = msgEvent.getData();
			    if( buf != null) {
			    	pushInputMessage(SPECIAL_STREAM_NAME, msgType, buf, msgTimestamp );
			    } else {
			    	log.info("----------------onAudioData failed, streamId={}, flvFrameByte= {}, curIndex={}, size={}", streamId, flvFrame[curIndex], curIndex, msgSize); 			    	
			    }
			}   

			Packet msg = new Packet(msgHeader, msgEvent);
			conn.handleMessageReceived(msg);
			//log.info("----------------onAudioData, streamId = {}, size={}", streamId, msgSize);         			
			break;
		    }
		case Constants.TYPE_VIDEO_DATA:
		    {
			VideoData msgEvent = new VideoData();
			msgEvent.setHeader(msgHeader);
			msgEvent.setTimestamp(msgTimestamp);
			msgEvent.setDataRemaining(flvFrame, curIndex, msgSize);     
			msgEvent.setSourceType(Constants.SOURCE_TYPE_LIVE);   
            		
			//send Karaoke to mixer directly
			if( isKaraoke ) {
			    IoBuffer buf = msgEvent.getData();
			    if( buf != null) {
			    	pushInputMessage(SPECIAL_STREAM_NAME, msgType, buf, msgTimestamp );
			    } else {
			    	log.info("----------------onVideoData failed, streamId = {}, flvFrameByte= {}, curIndex={}, size={}", streamId, flvFrame[curIndex], curIndex, msgSize); 			    	
			    }
			} 
    		
			Packet msg = new Packet(msgHeader, msgEvent);
			conn.handleMessageReceived(msg);
			//log.info("----------------onVideoData, streamId = {}, size={}", streamId, msgSize);
			break;
		    }
		    
		case Constants.TYPE_STREAM_METADATA:
		    {
			Notify msgEvent = new Notify(flvFrame, curIndex, msgSize);
			msgEvent.setHeader(msgHeader);
			msgEvent.setTimestamp(msgTimestamp);
			msgEvent.setSourceType(Constants.SOURCE_TYPE_LIVE);
			Packet msg = new Packet(msgHeader, msgEvent);
			conn.handleMessageReceived(msg);
			//log.info("----------------onCuePoint, streamId = {}, size={}", streamId, msgSize);
			break;
		    }
            	}
            	curIndex += (msgSize+4); //4 bytes unused
	    }
    	}
    }
    
    public RTMPMinaConnection getAllInOneConn()
    {
    	return (RTMPMinaConnection) RTMPConnManager.getInstance().getConnectionBySessionId(allInOneSessionId_);
    }
    
    private void handleConnectEvent(RTMPMinaConnection conn)
    {
    	///////////////////////////////////
    	//handle StreamAction.CONNECT event
    	//RTMP Chunk Header
    	Header connectMsgHeader = new Header();
    	connectMsgHeader.setDataType(Constants.TYPE_INVOKE);//invoke is command, val=20
    	connectMsgHeader.setChannelId(3); //3 means invoke command
    	// see RTMPProtocolDecoder::decodePacket() 
    	// final int readAmount = (readRemaining > chunkSize) ? chunkSize : readRemaining;
    	connectMsgHeader.setSize(1024);   //Chunk Data Length, a big enough buffersize
    	connectMsgHeader.setStreamId(0);  //0 means netconnection
    	connectMsgHeader.setTimerBase(0); //base+delta=timestamp
    	connectMsgHeader.setTimerDelta(0);
    	connectMsgHeader.setExtendedTimestamp(0); //extended timestamp
    	
    	//No need for PendingServiceCall only for callbacks with _result or _error
    	/*
    	  if (call instanceof IPendingServiceCall) {
    	  registerPendingCall(connectMsgEvent.getTransactionId(), (IPendingServiceCall) connectMsgEvent);
    	  }
    	*/   
    	PendingCall connectCall = new PendingCall( "connect");
    	Invoke connectMsgEvent = new Invoke(connectCall);
    	connectMsgEvent.setHeader(connectMsgHeader);
    	connectMsgEvent.setTimestamp(0);
    	connectMsgEvent.setTransactionId(1);
    	connectMsgEvent.setCall(connectCall);
    	
    	Map<String, Object> connectParams = new HashMap<String, Object>();
    	connectParams.put("app", AppName);
    	connectParams.put("flashVer", "FMSc/1.0");
    	connectParams.put("swfUrl", "a.swf");
    	connectParams.put("tcUrl", "rtmp://"+ipAddr+":1935/"+AppName); //server ip address
    	connectParams.put("fpad", false);
    	connectParams.put("audioCodecs", 0x0fff); //All codecs
    	connectParams.put("videoCodecs", 0x0ff); //All codecs
    	connectParams.put("videoFunction", 1); //SUPPORT_VID_CLIENT_SEEK
    	connectParams.put("pageUrl", "a.html");
    	connectParams.put("objectEncoding", 0); //AMF0
    	connectMsgEvent.setConnectionParams(connectParams);
    	
    	Packet connectMsg = new Packet(connectMsgHeader, connectMsgEvent);
    	conn.handleMessageReceived(connectMsg);    	
    	
    	log.info("A new connection event sent on thread: {}", Thread.currentThread().getName());
    }
    
    private void handleCreatePublishEvents(RTMPMinaConnection conn, String streamName, int streamId)
    {
    	///////////////////////////////////
    	//handle create Stream event
    	
    	//RTMP Chunk Header
    	Header createStreamMsgHeader = new Header();
    	createStreamMsgHeader.setDataType(Constants.TYPE_INVOKE);//invoke is command, val=20
    	createStreamMsgHeader.setChannelId(3); //3 means invoke command
    	// see RTMPProtocolDecoder::decodePacket() 
    	// final int readAmount = (readRemaining > chunkSize) ? chunkSize : readRemaining;
    	createStreamMsgHeader.setSize(1024);   //Chunk Data Length, a big enough buffersize
    	createStreamMsgHeader.setStreamId(0);  //0 means netconnection
    	createStreamMsgHeader.setTimerBase(0); //base+delta=timestamp
    	createStreamMsgHeader.setTimerDelta(0);
    	createStreamMsgHeader.setExtendedTimestamp(0); //extended timestamp
    	
    	PendingCall createStreamCall = new PendingCall( "createStream" );
    	Invoke createStreamMsgEvent = new Invoke(createStreamCall);
    	createStreamMsgEvent.setHeader(createStreamMsgHeader);
    	createStreamMsgEvent.setTimestamp(0);
    	createStreamMsgEvent.setTransactionId(2);
    	createStreamMsgEvent.setCall(createStreamCall);
    		
    	Packet createStreamMsg = new Packet(createStreamMsgHeader, createStreamMsgEvent);
    	conn.handleMessageReceived(createStreamMsg);
    	
    	///////////////////////////////////
    	//handle publish event
    	
    	//RTMP Chunk Header
    	Header publishMsgHeader = new Header();
    	publishMsgHeader.setDataType(Constants.TYPE_INVOKE);//invoke is command, val=20
    	publishMsgHeader.setChannelId(3); //3 means invoke command
    	// see RTMPProtocolDecoder::decodePacket() 
    	// final int readAmount = (readRemaining > chunkSize) ? chunkSize : readRemaining;
    	publishMsgHeader.setSize(1024);   //Chunk Data Length, a big enough buffersize
    	publishMsgHeader.setStreamId(streamId);  // the newly created stream id
    	publishMsgHeader.setTimerBase(0); //base+delta=timestamp
    	publishMsgHeader.setTimerDelta(0);
    	publishMsgHeader.setExtendedTimestamp(0); //extended timestamp
    	
    	Object [] publishArgs = new Object[2];
    	publishArgs[0] = streamName;
    	publishArgs[1] = "live";
    	PendingCall publishCall = new PendingCall( "publish", publishArgs );
    	Invoke publishMsgEvent = new Invoke(publishCall);
    	publishMsgEvent.setHeader(publishMsgHeader);
    	publishMsgEvent.setTimestamp(0);
    	publishMsgEvent.setTransactionId(3);
    	publishMsgEvent.setCall(publishCall);
    	
    	Packet publishMsg = new Packet(publishMsgHeader, publishMsgEvent);
    	conn.handleMessageReceived(publishMsg);
        
        ///////////////////////////////////
        //handle chunksize event
        
        //RTMP Chunk Header
        Header chunkSizeMsgHeader = new Header();
        chunkSizeMsgHeader.setDataType(Constants.TYPE_CHUNK_SIZE);//invoke is command, val=1
        chunkSizeMsgHeader.setChannelId(2); //2 means protocol control message
        // see RTMPProtocolDecoder::decodePacket() 
        // final int readAmount = (readRemaining > chunkSize) ? chunkSize : readRemaining;
        chunkSizeMsgHeader.setSize(1024);   //Chunk Data Length, a big enough buffersize
        chunkSizeMsgHeader.setStreamId(streamId);  //the newly created stream
        chunkSizeMsgHeader.setTimerBase(0); //base+delta=timestamp
        chunkSizeMsgHeader.setTimerDelta(0);
        chunkSizeMsgHeader.setExtendedTimestamp(0); //extended timestamp
        
        ChunkSize chunkSizeMsgEvent = new ChunkSize(0xffffff); //maxsize
        chunkSizeMsgEvent.setHeader(chunkSizeMsgHeader);
        chunkSizeMsgEvent.setTimestamp(0);
        
        Packet chunkSizeMsg = new Packet(chunkSizeMsgHeader, chunkSizeMsgEvent);
        conn.handleMessageReceived(chunkSizeMsg);
        
		log.info("A new stream with id {} name {} is created on thread: {}", streamId, streamName, Thread.currentThread().getName());
    }

    private void handleDeleteEvent(RTMPMinaConnection conn, int streamId)
    {
		///////////////////////////////////
		//handle delete Stream event

		//RTMP Chunk Header
		Header deleteStreamMsgHeader = new Header();
		deleteStreamMsgHeader.setDataType(Constants.TYPE_INVOKE);//invoke is command, val=20
		deleteStreamMsgHeader.setChannelId(3); //3 means invoke command
		// see RTMPProtocolDecoder::decodePacket() 
		// final int readAmount = (readRemaining > chunkSize) ? chunkSize : readRemaining;
		deleteStreamMsgHeader.setSize(1024);   //Chunk Data Length, a big enough buffersize
		deleteStreamMsgHeader.setStreamId(0);  //0 means netconnection
		deleteStreamMsgHeader.setTimerBase(0); //base+delta=timestamp
		deleteStreamMsgHeader.setTimerDelta(0);
		deleteStreamMsgHeader.setExtendedTimestamp(0); //extended timestamp

		Object [] deleteArgs = new Object[1];
		deleteArgs[0] = streamId;
		PendingCall deleteStreamCall = new PendingCall( "deleteStream", deleteArgs );
		Invoke deleteStreamMsgEvent = new Invoke(deleteStreamCall);
		deleteStreamMsgEvent.setHeader(deleteStreamMsgHeader);
		deleteStreamMsgEvent.setTimestamp(0);
		deleteStreamMsgEvent.setTransactionId(0);
		deleteStreamMsgEvent.setCall(deleteStreamCall);
		
		Packet deleteStreamMsg = new Packet(deleteStreamMsgHeader, deleteStreamMsgEvent);
		conn.handleMessageReceived(deleteStreamMsg);

		log.info("A old stream with id {} is deleted on thread: {}", streamId, Thread.currentThread().getName());
    }

	@Override
	public void onKaraokeFrameParsed(ByteBuffer frame, int len) {
		//either send it to the original stream or delayed stream.
		int streamId = idLookupTable.lookupStreamId(SPECIAL_STREAM_NAME);
		onFrameGenerated(streamId, frame, len, true);
	}

	@Override
    public void onSongPlaying(String songName) {
    	RTMPConnection conn = getAllInOneConn();
    	conn.onSongPlaying(songName);
    }
	public void selectSong(String songName) {
		karaokeGen_.selectSong(songName);
	}
}
