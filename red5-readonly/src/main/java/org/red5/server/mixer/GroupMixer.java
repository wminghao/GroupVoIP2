package org.red5.server.mixer;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.mina.core.buffer.IoBuffer;
import org.red5.logging.Red5LoggerFactory;
import org.red5.server.api.Red5;
import org.red5.server.api.scope.IScope;
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
import org.slf4j.Logger;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

import java.nio.ByteBuffer;

public class GroupMixer implements SegmentParser.Delegate, KaraokeGenerator.Delegate, ApplicationContextAware, DisposableBean {

    public static final String MIXED_STREAM_PREFIX = "__mixed__";
    public static final String ALL_IN_ONE_STREAM_NAME = "allinone";
    public static final String SPECIAL_STREAM_NAME = "karaoke"; //test name
    private static final String AppName = "VisparApp";//appName.
    private static final String ipAddr = "localhost"; //ignore
    private static GroupMixer instance_;
    private static Logger log = Red5LoggerFactory.getLogger(Red5.class);
    
    private IRTMPHandler handler_ = null; //global handler used in creating RTMPConnections
    
    private MinaLoadServer loadServer = new MinaLoadServer();
    
    private MinaRoomClient roomNotificationClient = new MinaRoomClient();
    
	//spring members from configuration
	protected static ApplicationContext applicationContext;
	private boolean bShouldMix;
	private boolean bLoadSegFromDisc; //read from a segment file instead
	private boolean bSaveSegToDisc; //log input segment file to a disc
	private boolean bSaveFlvToDisc; //log input segment file to a disc
	private boolean bGenKaraoke; //should use karaoke
	private String outputSegPath;
	private String outputFlvPath;
	private String inputSegPath;	
	private String karaokeFilePath;
	
	//map to different rooms
	private Map<IScope,MixerRoom> mixerRooms_ = new HashMap<IScope, MixerRoom>();
	
	//mixcoder bridge is shared among all rooms, singleton, created only once
    private MixCoderBridge mixCoderBridge_ = new MixCoderBridge();
    
    //current supported mixing threshold.
    private static int CURRENT_SUPPORTED_THRESHOLD = IdLookup.MAX_STREAM_COUNT-1; //for now, only 9 streams are supported
	
    private GroupMixer() {
    	//launch a stats service for listening input from load balancer.
    	loadServer.start();
    }
    
	@Override
	public void destroy() throws Exception {
		//never called.
    	loadServer.stop();
	}
	
    public static synchronized GroupMixer getInstance() {
        if(instance_ == null) {
        	instance_ = (GroupMixer) applicationContext.getBean("groupMixer");
        }
        return instance_;
    }

    public void prepare(IRTMPHandler handler)
	{ 	
    	if( handler_ == null ) {
        	handler_ = handler;
    	}
    	log.info("prepare GroupMixer!");
	}
    
    private void createAllInOneConn( MixerRoom mixerRoom )
    {
    	if( mixerRoom.allInOneSessionId_ == null ) {    	    
    	    // create a connection
    	    RTMPMinaConnection connAllInOne = (RTMPMinaConnection) RTMPConnManager.getInstance().createConnection(RTMPMinaConnection.class, false);
    	    // add session to the connection
    	    connAllInOne.setIoSession(null);
    	    // add the handler
    	    connAllInOne.setHandler(handler_);
    	    //specify it's a special connection
    	    connAllInOne.setGroupMixerFlag();
    	    
    	    // set it in MixerManager
    	    mixerRoom.allInOneSessionId_ = connAllInOne.getSessionId();
    	    
    	    //??? different thread , see mina threading model ???
    	    //next assume the session is opened
    	    handler_.connectionOpened(connAllInOne);
    	    
    	    //handle connect, createStream and publish events
    	    handleConnectEvent(connAllInOne, mixerRoom.scopeName_);
    	}
	    //kick off createStream event
    	createMixedStreamInternal(mixerRoom, ALL_IN_ONE_STREAM_NAME);
	    	    
	    //start all other services
	    mixerRoom.startService();
	    
	    //notify load balancer
	    roomNotificationClient.onRoomCreated(mixerRoom.scopeName_);
	    log.info("Created all In One connection with bMixerOpenedSuccess_={} sessionId {} on thread: {}", mixerRoom.bMixerOpenedSuccess_, mixerRoom.allInOneSessionId_, Thread.currentThread().getName());
    }

    private MixerRoom getMixerRoom(IScope roomScope) {
    	MixerRoom mixerRoom = null;
    	if( mixerRooms_.containsKey(roomScope) ) {
    		mixerRoom = mixerRooms_.get(roomScope);
    	} 
    	return mixerRoom;
	}
    private MixerRoom getAndCreateMixerRoom(IScope roomScope) {
    	MixerRoom mixerRoom = null;
    	if( mixerRooms_.containsKey(roomScope) ) {
    		mixerRoom = mixerRooms_.get(roomScope);
    	} else {
    		mixerRoom = new MixerRoom(this,
    				  mixCoderBridge_,
    				  roomScope,
    				  bShouldMix,
            		  bLoadSegFromDisc, //read from a segment file instead
            		  bSaveSegToDisc, //log input segment file to a disc
            		  bSaveFlvToDisc, //log input segment file to a disc
            		  bGenKaraoke, //should use karaoke
            		  outputSegPath,
            		  outputFlvPath,
            		  inputSegPath,	
            		  karaokeFilePath);
    		mixerRooms_.put(roomScope, mixerRoom);
    	}
    	return mixerRoom;
    }
    
    public void createMixedStream(IScope roomScope, String streamName)
    {
    	MixerRoom mixerRoom = getAndCreateMixerRoom(roomScope);
    	if( mixerRoom.idLookupTable_.isEmpty() ) {
    		//next creates the all-in-one RTMPMinaConnection
    		createAllInOneConn(mixerRoom);
    	}
    	createMixedStreamInternal(mixerRoom, streamName);
    	mixerRoom.populateVideoList(streamName);//send video list to the client
    }  
    
    public boolean isExternalVideoGenerated(IScope roomScope) {
    	MixerRoom mixerRoom = getMixerRoom(roomScope);
    	if( mixerRoom != null ) {
    		return mixerRoom.karaokeGen_.isStarted();
    	} else {
    		return false;
    	}
    }

    public void clearVideoFrame(IScope roomScope, String streamName)
    {
    	MixerRoom mixerRoom = getMixerRoom(roomScope);
    	if( mixerRoom!=null ) {
    		mixerRoom.idLookupTable_.setClearVideoFrameFlag(streamName);
    	}    	
    }

    /*
     * deleteMixedStream should avoid a situation that original stream is deleted and idLookupTable_.getCount() becomes 0, 
     * other thread will treat the connection as closed and free up the whole netconnection.
     */
    public void deleteMixedStream(IScope roomScope, String streamName)
    {
    	MixerRoom mixerRoom = getMixerRoom(roomScope);
    	boolean bShouldFreeAllInOne = false;
    	if ( mixerRoom!= null && mixerRoom.idLookupTable_.lookupMixerId(streamName) != -1 ) {
        	log.info("Before deleting stream {}, idLookupTable cnt={}", streamName, mixerRoom.idLookupTable_.getCount());
        	//if all streams will be removed, remove the special stream and free up the mixer
        	int totalCount = mixerRoom.idLookupTable_.getCount();
    		//if there is only 2 stream, which is the special stream + the original stream, also clean up everything
        	if( totalCount == 2 && mixerRoom.karaokeGen_!= null ) {
        		if( mixerRoom.karaokeGen_.isStarted() ) {
        			bShouldFreeAllInOne = true;
        		}
        	} else if( totalCount == 1) {
        		//if there is only 1 stream, which is the original stream, clean up everything.
        		bShouldFreeAllInOne = true;
        	}
        	if( bShouldFreeAllInOne ) {
            	mixerRoom.stopService();
        	    //shutdown all in one stream
            	deleteMixedStreamInternal(mixerRoom, ALL_IN_ONE_STREAM_NAME);
        	    
        	    //shutdown karaoke stream
        	    if( mixerRoom.karaokeGen_!= null ) {
        	    	deleteMixedStreamInternal(mixerRoom, SPECIAL_STREAM_NAME);
        	    }
        	}
        	//delete the original stream last.
        	deleteMixedStreamInternal(mixerRoom, streamName);
        	
        	if( bShouldFreeAllInOne ) {
        	    //remove connection
        	    RTMPConnManager.getInstance().removeConnection(mixerRoom.allInOneSessionId_);
        	    mixerRoom.allInOneSessionId_ = null;
        	    //notify load balancer
        	    roomNotificationClient.onRoomClosed(roomScope.getName());
        	    mixerRooms_.remove(roomScope);
        		log.info("Deleted all In One connection with bMixerOpenedSuccess_={} sessionId {} on thread: {}", mixerRoom.bMixerOpenedSuccess_, mixerRoom.allInOneSessionId_, Thread.currentThread().getName());
        	}
    	}
    }
    
    private void createMixedStreamInternal(MixerRoom mixerRoom, String streamName) {
    	if( mixerRoom.idLookupTable_.lookupMixerId(streamName) == -1 ) {
        	int newStreamId = mixerRoom.idLookupTable_.createNewEntry(streamName);
        
        	RTMPMinaConnection conn = getAllInOneConn(mixerRoom);
        	if( conn != null ) {
        		handleCreatePublishEvents(conn, MIXED_STREAM_PREFIX+streamName, newStreamId);
        	} else {
            	log.info("----------------fatal error allInone stream not found sessionId = {}", mixerRoom.allInOneSessionId_);
        	}
    	}
    }
    
    private int deleteMixedStreamInternal(MixerRoom mixerRoom, String streamName)
    {
    	log.info("deleteMixedStreamInternal {}", streamName);
    	int streamId = mixerRoom.idLookupTable_.lookupStreamId(streamName);
    	if ( streamId != -1 ) {        	
    		RTMPMinaConnection conn = getAllInOneConn(mixerRoom);
    		//it's possible the connection is already deleted from a different thread. don't need to delete it again.
    		if( conn != null ) {
    			handleDeleteEvent(conn, streamId);
    		}
    	}
    	mixerRoom.idLookupTable_.deleteEntry(streamName);
    	return streamId;
    }
    
    public void pushInputMessage(IScope roomScope, String streamName, int msgType, IoBuffer buf, int eventTime)
    {	
    	MixerRoom mixerRoom = getMixerRoom(roomScope);
    	if( mixerRoom!= null ) {
    		pushInputMessage(mixerRoom, streamName, msgType, buf, eventTime);
    	}
    }
    
    private void pushInputMessage(MixerRoom mixerRoom, String streamName, int msgType, IoBuffer buf, int eventTime) {	
    	if( buf.limit() > 0 && mixerRoom.mixerPipe_ != null && mixerRoom.bMixerOpenedSuccess_ ) {
    		//log.info("----------------pushInputMessage, buf.limit()={}, mixerPipe_={}, bMixerOpenedSuccess_={}", buf.limit(), mixerPipe_, bMixerOpenedSuccess_);
    		mixerRoom.mixerPipe_.handleSegInput(mixerRoom.idLookupTable_, streamName, msgType, buf, eventTime);
    	}
    }

    public void onFrameParsed(IScope roomScope, int mixerId, ByteBuffer frame, int flvFrameLen)
    {
    	MixerRoom mixerRoom = getMixerRoom(roomScope);
    	if( mixerRoom!= null ) {
    		int streamId = mixerRoom.idLookupTable_.lookupStreamId(mixerId);
    		//log.info("=====>onFrameParsed mixerId {} len {} streamName {}", mixerId, flvFrameLen, idLookupTable.lookupStreamName(mixerId) );
    		onFrameGenerated(mixerRoom, mixerId, streamId, frame, flvFrameLen, false );
    	}
    }
    
    private void onFrameGenerated(MixerRoom mixerRoom, int mixerId, int streamId, ByteBuffer frame, int flvFrameLen, boolean isKaraoke) {
    	if ( streamId != -1 ) {
    	    byte[] flvFrame = frame.array();
    	    int curIndex = 0;
    	    if(flvFrame[0] =='F' && flvFrame[1]=='L' && flvFrame[2] == 'V') {
    	    	curIndex+=13;
    	    }        		

    	    if( bSaveFlvToDisc ) {
    	    	if( mixerId == IdLookup.ALL_IN_ONE_STREAM_MIXER_ID ) {
    	    		mixerRoom.flvArchiver_.archiveData(frame, curIndex, flvFrameLen);
    	    	}
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
                		
                RTMPMinaConnection conn = getAllInOneConn(mixerRoom);
                if( conn != null ) { 
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
                			    	pushInputMessage(mixerRoom, SPECIAL_STREAM_NAME, msgType, buf, msgTimestamp );
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
                			    	pushInputMessage(mixerRoom, SPECIAL_STREAM_NAME, msgType, buf, msgTimestamp );
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
                }
                curIndex += (msgSize+4); //4 bytes unused
    	    }
    	}
    }
    
    private RTMPMinaConnection getAllInOneConn(MixerRoom mixerRoom)
    {
    	return (RTMPMinaConnection) RTMPConnManager.getInstance().getConnectionBySessionId(mixerRoom.allInOneSessionId_);
    }

    public boolean isAllInOneConn(IScope roomScope, RTMPConnection conn )
    {
    	return (conn == getAllInOneConn(roomScope));
    }
    public RTMPMinaConnection getAllInOneConn(IScope roomScope)
    {
    	MixerRoom mixerRoom = getMixerRoom(roomScope);
    	if( mixerRoom != null ) {
    		return getAllInOneConn(mixerRoom);
    	} else {
    		return null;
    	}
    }
    
    private void handleConnectEvent(RTMPMinaConnection conn, String scopeName)
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
    	connectParams.put("app", AppName+"/"+scopeName);
    	connectParams.put("flashVer", "FMSc/1.0");
    	connectParams.put("swfUrl", "a.swf");
    	connectParams.put("tcUrl", "rtmp://"+ipAddr+"/"+AppName+"/"+scopeName); //server ip address
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
	public void onKaraokeFrameParsed(IScope roomScope, ByteBuffer frame, int len) {
    	MixerRoom mixerRoom = getMixerRoom(roomScope);
		//either send it to the original stream or delayed stream.
		onFrameGenerated(mixerRoom, mixerRoom.idLookupTable_.lookupMixerId(SPECIAL_STREAM_NAME), 
						 mixerRoom.idLookupTable_.lookupStreamId(SPECIAL_STREAM_NAME), 
						 frame, len, true);
	}

	@Override
    public void onExternalVideoPlaying(IScope roomScope, String videoName) {
    	RTMPConnection conn = getAllInOneConn(roomScope);
    	if( conn != null ) {
    		conn.onExternalVideoPlaying(videoName);
    	}
    }
	@Override
    public void onExternalVideoStarted(IScope roomScope) {
    	RTMPConnection conn = getAllInOneConn(roomScope);
    	if( conn != null ) {
    		conn.onExternalVideoStarted();
    	}
    }
	@Override
    public void onExternalVideoStopped(IScope roomScope) {
    	RTMPConnection conn = getAllInOneConn(roomScope);
    	if( conn != null ) {
    		conn.onExternalVideoStopped();
    	}
    }

	@Override
    public void onExternalVideoListPopulated(IScope roomScope, String streamName, String videoListNames) {
    	RTMPConnection conn = getAllInOneConn(roomScope);
    	if( conn != null ) {
    		conn.onExternalVideoListPopulated(streamName, videoListNames);
    	}
    }
	
	//from client to server
	public void selectExternalVideo(IScope roomScope, String videoName) {
    	MixerRoom mixerRoom = getMixerRoom(roomScope);
    	if( mixerRoom!=null && mixerRoom.karaokeGen_ != null ) {
    		mixerRoom.karaokeGen_.selectExternalVideo(videoName);
    		if( !mixerRoom.karaokeGen_.isStarted() && mixerRoom.idLookupTable_.getCount() < CURRENT_SUPPORTED_THRESHOLD) {
    	    	createMixedStreamInternal(mixerRoom, SPECIAL_STREAM_NAME);
    			mixerRoom.karaokeGen_.tryToStart();
    		}
    	}
	}
	public void stopExternalVideo(IScope roomScope) {
		MixerRoom mixerRoom = getMixerRoom(roomScope);
    	if(  mixerRoom!=null && mixerRoom.karaokeGen_ != null ) {
    		if( mixerRoom.karaokeGen_.isStarted() ) {
    			mixerRoom.karaokeGen_.tryToStop();
    	    	deleteMixedStreamInternal(mixerRoom, SPECIAL_STREAM_NAME);
    		}
    	}	
	}

	//from client to server
	public Boolean isEmptyStream(IScope roomScope) {
		MixerRoom mixerRoom = getMixerRoom(roomScope);
    	if( mixerRoom != null ) {
    		return mixerRoom.idLookupTable_.isEmpty();
    	} else {
    		return true;
    	}
	}
	
	/**
	 * Setter for bShouldMix.
	 *
	 * @param tells GroupMixer's whether to mix or not
	 */
	public void setbShouldMix(boolean bShouldMix) {
		this.bShouldMix = bShouldMix;
	}	
	/**
	 * Setter for bLoadSegFromDisc.
	 *
	 * @param tells GroupMixer's process Pipe if load output from disc or not
	 */
	public void setbLoadSegFromDisc(boolean bLoadSegFromDisc) {
		this.bLoadSegFromDisc = bLoadSegFromDisc;
	}
	/**
	 * Setter for bSaveSegToDisc.
	 *
	 * @param tells GroupMixer's process Pipe if save seg to disc or not
	 */
	public void setbSaveSegToDisc(boolean bSaveSegToDisc) {
		this.bSaveSegToDisc = bSaveSegToDisc;
	}	
	/**
	 * Setter for bSaveFlvToDisc.
	 *
	 * @param tells GroupMixer's process Pipe if save flv to disc or not
	 */
	public void setbSaveFlvToDisc(boolean bSaveFlvToDisc) {
		this.bSaveFlvToDisc = bSaveFlvToDisc;
	}	
	/**
	 * Setter for bGenKaraoke.
	 *
	 * @param tells GroupMixer's whether to gen karaoke or not
	 */
	public void setbGenKaraoke(boolean bGenKaraoke) {
		this.bGenKaraoke = bGenKaraoke;
	}	
	/**
	 * Setter for inputSegPath.
	 *
	 * @param tells GroupMixer's process Pipe input file path
	 */
	public void setinputSegPath(String inputSegPath) {
		this.inputSegPath = inputSegPath;
	}
	/**
	 * Setter for outputSegPath.
	 *
	 * @param tells GroupMixer's process Pipe output file path
	 */
	public void setoutputSegPath(String outputSegPath) {
		this.outputSegPath = outputSegPath;
	}	
	/**
	 * Setter for outputFlvPath.
	 *
	 * @param tells GroupMixer's process Pipe output file path
	 */
	public void setoutputFlvPath(String outputFlvPath) {
		this.outputFlvPath = outputFlvPath;
	}
	/**
	 * Setter for karaokePath.
	 *
	 * @param tells GroupMixer's where is karaoke
	 */
	public void setkaraokeFilePath(String karaokeFilePath) {
		this.karaokeFilePath = karaokeFilePath;
	}
	/*
	 * Default spring applicationcontext
	 */
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		GroupMixer.applicationContext = applicationContext;
	}
	
	/*
	 * Stats about the current server load
	 */
	public class StatsObject
	{
		public String owner_;
		public int numOfSpeakers_;
		public int numOfVieweres_;
	}
	
	public List<StatsObject> getStats() {
		List<StatsObject> statsList = new ArrayList<StatsObject>();
		Iterator<Entry<IScope, MixerRoom>> it = mixerRooms_.entrySet().iterator();
	    while (it.hasNext()) {
	    	Entry<IScope, MixerRoom> pair = (Entry<IScope, MixerRoom>)it.next();
	        MixerRoom room = (MixerRoom)pair.getValue();
	        StatsObject obj = new StatsObject();
	        obj.owner_ = room.scopeName_;
	        obj.numOfSpeakers_ = room.idLookupTable_.getTotalInputStreams();
	        obj.numOfVieweres_ = 0; //TODO for now don't care.
	        statsList.add(obj);
	    }
		return statsList;
	}
}
