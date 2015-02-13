package org.red5.server.mixer;

import java.util.concurrent.atomic.AtomicInteger;

import org.red5.server.api.scope.IScope;

public class MixerRoom {
    public String allInOneSessionId_ = null; //all-in-one mixer rtmp connection
    public IdLookup idLookupTable_ = new IdLookup();
    
    // Java processPipe vs. native Process pipe
    // private ProcessPipe mixerPipe_ = null;
    public NativeProcessPipe mixerPipe_ = null;
    public boolean bMixerOpenedSuccess_ = false;
    
    //special stream
    public KaraokeGenerator karaokeGen_ = null;
    //flv archiver
    public FLVArchiver flvArchiver_;
    
    //remember the name of the scope
    public String scopeName_;

	//a statemachine to indicate whether allInOneStream is connected or not?
	public AtomicInteger allInOneConnStatus_ = new AtomicInteger(ALLINCONN_NOT_STARTED);
    public static final int ALLINCONN_NOT_STARTED = 0;
    public static final int ALLINCONN_IN_PROGRESS = 1;
    public static final int ALLINCONN_CONNECTED   = 2;
	
    //creates a mixerRoom
    public MixerRoom( GroupMixer groupMixer,
    			      MixCoderBridge mixCoderBridge,
    				  IScope scope,
    				  boolean bShouldMix,
            		  boolean bLoadSegFromDisc, //read from a segment file instead
            		  boolean bSaveSegToDisc, //log input segment file to a disc
            		  boolean bSaveFlvToDisc, //log input segment file to a disc
            		  boolean bGenKaraoke, //should use karaoke
            		  String outputSegPath,
            		  String outputFlvPath,
            		  String inputSegPath,	
            		  String karaokeFilePath) {

    	scopeName_ = scope.getName();
	    //starts process pipe
	    if( bShouldMix ) {
	    	mixerPipe_ = new NativeProcessPipe(groupMixer, scope, mixCoderBridge, bSaveSegToDisc, outputSegPath, bLoadSegFromDisc, inputSegPath);
	    }
	    if( bGenKaraoke ) {
	    	karaokeGen_ = new KaraokeGenerator(groupMixer, scope, karaokeFilePath);
	    }
	    if( bSaveFlvToDisc ) {
	    	flvArchiver_ = new FLVArchiver(outputFlvPath, scopeName_);
	    }
    }
    
    public void startService(){
	    if( mixerPipe_ != null) {
	    	bMixerOpenedSuccess_ = mixerPipe_.open(); 
	    }

	    if( flvArchiver_!=null ) {
	    	flvArchiver_.startArchive();
	    }

    	if( karaokeGen_ != null ) {
    		karaokeGen_.tryToStart();
    	}
    }
    
    public void stopService() {
    	//close the process pipe
    	if( mixerPipe_ != null ) {
    		mixerPipe_.close();
    	}
	    if( flvArchiver_!=null ) {
	    	flvArchiver_.stopArchive();
	    }
    	if( karaokeGen_ != null ) {
    		karaokeGen_.tryToStop();
    	}
    }
    public boolean isExternalVideoStarted() {
    	return karaokeGen_.isStarted();
    }
    
    public void populateVideoList(String streamName){
    	if( karaokeGen_ != null ) {
    		karaokeGen_.populateVideoList(streamName);
    	}
    }
}
