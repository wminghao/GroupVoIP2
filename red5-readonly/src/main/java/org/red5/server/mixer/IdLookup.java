package org.red5.server.mixer;

import java.util.BitSet;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.red5.logging.Red5LoggerFactory;
import org.red5.server.api.Red5;
import org.slf4j.Logger;

public class IdLookup {
	public static final int MAX_STREAM_COUNT = 32;
	//both original karaoke stream and allinone stream should not be mixed
	public static final int ALL_IN_ONE_STREAM_MIXER_ID = MAX_STREAM_COUNT;
	private static final int TOTAL_EXCLUDE_COUNT = 1; //exclude all-in-one stream
	//mapping from original to streamId to newly generated stream
	public class GroupMappingTableEntry {
		public int 	mixerId; //streamId used in MixCoder
		public int	streamId; //streamId used in RTMP protocol
		public int 	shouldClearVideoFrame; //a flag to indicate whether video frame needs to be cleared for audio only mode.
	}
	//synchronized among different threads
	private Map<String,GroupMappingTableEntry> groupMappingTable=new ConcurrentHashMap<String,GroupMappingTableEntry>();
	int totalInputStreams = 0;
	/**
	 * Reserved stream ids. Stream id's directly relate to individual NetStream instances.
	 */
	private volatile BitSet reservedStreams = new BitSet();
	/**
	 * Reserved mixer ids. Mixer id's directly relate to mixcoder.
	 */
	private volatile BitSet mixerStreams = new BitSet();

	private static Logger log = Red5LoggerFactory.getLogger(Red5.class);
    
    //map streamId to the actual streamId in StreamService class
    private int reserveStreamId() {
    	int result = -1;
    	for (int i = 0; true; i++) {
    	    if (!reservedStreams.get(i)) {
    	    	reservedStreams.set(i);
    	    	result = i;
    	    	break;
    	    }
    	}
    	return result + 1;
    }
    
    private void unreserveStreamId(int streamId) {
    	if (streamId > 0) {
    	    reservedStreams.clear(streamId - 1);
    	}
    }
    
    //map streamId to the 0-MAX_STREAM_COUNT streamId used in mixcoder
    private int reserveMixerId(String streamName) {
    	int result = -1;
    	if(streamName.equalsIgnoreCase(GroupMixer.ALL_IN_ONE_STREAM_NAME)) {
    	    result = ALL_IN_ONE_STREAM_MIXER_ID; //should not be mixed
    	} else {
    	    for (int i = 0; true; i++) {
        		if (!mixerStreams.get(i)) {
        		    mixerStreams.set(i);
        		    result = i;
        		    break;
        		}
    	    }
    	}
    	return result;
    }
    //return a mask of mixerid
    private int getMixerMask() {
    	int result = 0;
    	for (int i = MAX_STREAM_COUNT-1; i>=0; i--) {
    	    if (mixerStreams.get(i)) {
    		result |= 0x1;
    	    }
    	    if( i > 0 ) {
    		result <<= 1;
    	    }
    	}
    	//log.info("======>getMixerMask value={}", result);
    	return result;
    }
    
    private void unreserveMixerId(int mixerId) {
    	if (mixerId >= 0) {
    	    mixerStreams.clear(mixerId);
    	}
    }
    
    public int lookupStreamId(int mixerId) {
    	int streamId = -1;
	    for(String key : groupMappingTable.keySet()) {
    		GroupMappingTableEntry value = groupMappingTable.get(key);
    		if(value.mixerId == mixerId) {
    		    streamId = value.streamId;
    		}
        }
    	return streamId;
    }
    public String lookupStreamName(int mixerId) {
    	String streamName = null;
    	for(String key : groupMappingTable.keySet()) {
    		GroupMappingTableEntry value = groupMappingTable.get(key);
    		if(value.mixerId == mixerId) {
    		    streamName = key;
    		}
    	}
    	return streamName;
    }
    public int lookupStreamId(String streamName) {
    	int streamId = -1;
    	GroupMappingTableEntry entry = groupMappingTable.get(streamName);
    	if ( entry != null ) {     
    		streamId = entry.streamId;
    	}
    	return streamId;
    }
    public int lookupMixerInfoAndClearFlags(String streamName, int [] result) {
    	int mixerId = -1;
	    GroupMappingTableEntry entry = groupMappingTable.get(streamName);
	    if ( entry != null ) {     
    		mixerId = entry.mixerId;
    		result[0] = getMixerMask();
    		result[1] = (totalInputStreams - TOTAL_EXCLUDE_COUNT);
    		result[2] = entry.shouldClearVideoFrame;
    		entry.shouldClearVideoFrame = 0;
	    }
    	return mixerId;
    }
    public int lookupMixerId(String streamName) {
    	int mixerId = -1;
	    GroupMappingTableEntry entry = groupMappingTable.get(streamName);
	    if ( entry != null ) {     
	    	mixerId = entry.mixerId;
	    }
    	return mixerId;
    }
    
    public int createNewEntry(String streamName) {
    	GroupMappingTableEntry entry = new GroupMappingTableEntry();
	    entry.mixerId = reserveMixerId(streamName);
	    entry.streamId = reserveStreamId();
	    entry.shouldClearVideoFrame = 0;
	    groupMappingTable.put(streamName, entry);
	    totalInputStreams++;
    	log.info("A new stream id: {}, mixer id: {} name: {} is created on thread: {}", entry.streamId, entry.mixerId, streamName, Thread.currentThread().getName());
    	return entry.streamId;
    }
    
    public int deleteEntry(String streamName) {
    	int streamId = -1;
	    GroupMappingTableEntry entry = groupMappingTable.get(streamName);
	    if ( entry != null ) {
        	unreserveStreamId(entry.streamId);
        	unreserveMixerId(entry.mixerId);
        	groupMappingTable.remove(streamName);
        	streamId = entry.streamId;
        	totalInputStreams--;
        	log.info("A old stream id: {}, mixer id: {} is deleted on thread: {}", entry.streamId, entry.mixerId, Thread.currentThread().getName());
	    }
    	return streamId;
    }
    
    public boolean isEmpty() {
    	return (getMixerMask() == 0 );
    }
    public int getCount() {
    	int result = 0;
    	for (int i = MAX_STREAM_COUNT-1; i>=0; i--) {
    	    if (mixerStreams.get(i)) {
    	    	result++;
    	    }
    	}
    	//log.info("======>getCount value={}", result);
    	return result;
    }

    public int setClearVideoFrameFlag(String streamName) {
    	int mixerId = -1;
    	if( streamName != null ) {
    	    GroupMappingTableEntry entry = groupMappingTable.get(streamName);
    	    if ( entry != null ) {     
    	    	entry.shouldClearVideoFrame = 1;
    	    }
    	} else {
    		log.info("-----setClearVideoFrameFlag failed b/c streamName is null!");
    	}
    	return mixerId;
    }

    public int getTotalInputStreams() {
    	int total = -1;
    	total = (totalInputStreams - TOTAL_EXCLUDE_COUNT);
    	return total;
    }
}
