package org.red5.server.mixer;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.atomic.AtomicBoolean;

import org.red5.logging.Red5LoggerFactory;
import org.red5.server.api.Red5;
import org.red5.server.api.scope.IScope;
import org.slf4j.Logger;

public class KaraokeGenerator implements Runnable, FLVParser.Delegate {
    private final static String defaultSong = "Default";
    private Delegate delegate_;
    private String karaokeFilePath_;
    private FLVParser flvParser_ = null;
    private static Logger log = Red5LoggerFactory.getLogger(Red5.class);
    private LinkedList<FLVFrameObject> flvFrameQueue_ = new LinkedList<FLVFrameObject>();
    //private final static long DELAY_INTERVAL = 100; //delay for 100 milliseconds.
    private int firstPTS_ = 0xffffffff;
    private int lastTimestamp_ = 0;
    private AtomicBoolean bStarted_ = new AtomicBoolean(false);
    
    //key is fileName, value is song name
    Map<String,String> songMappingTable_ = new HashMap<String, String>();
    String curSongFile_ = "";
    String curSongName_ = "";
    private AtomicBoolean bCancelCurrentSong = new AtomicBoolean(false);
    
    private IScope scope_ = null;
    
    private class FLVFrameObject
    {
    	public ByteBuffer frame;
    	public int timestamp;
    	public FLVFrameObject(ByteBuffer frame, int len, int timestamp) {
    	    this.frame = ByteBuffer.allocate(len);
    	    this.frame.put(frame.array(), 0, len);
    	    this.frame.flip();
    	    this.timestamp = timestamp;
    	}
    }
    
    public interface Delegate {
        public void onKaraokeFrameParsed(IScope roomScope, ByteBuffer frame, int len);
        public void onVideoPlaying(IScope roomScope, String videoName);
        public void onVideoListPopulated(IScope roomScope, String streamName, String videoListNames);
    }
    
    public KaraokeGenerator(KaraokeGenerator.Delegate delegate, IScope roomScope, String karaokeFilePath){
    	this.delegate_ = delegate;
    	this.scope_ = roomScope;
    	this.karaokeFilePath_ = karaokeFilePath;
    	readSongMappingTable();
    }
    
    public void tryToStart() {
    	if( bStarted_.compareAndSet(false, true) ) {
    		Thread thread = new Thread(this, "KaraokeThread");
    		thread.start();
    	}
    }
    public void tryToStop() {
    	bStarted_.set(false);
    }
    
    private void loadASong(String fileName) {
    	firstPTS_ = 0xffffffff;
    	nextAsDefaultSong(); //set next as default song
        long startTime = System.currentTimeMillis();
        try {
        	File file = new File(fileName);
            log.info("Open a file {} size: {}", fileName, file.length());
        	flvParser_ = new FLVParser(this, lastTimestamp_);
        	InputStream input = null;
        	try {
    	    	int bytesTotal = 0;
    	    	byte[] result = new byte[4096];
    	        input = new BufferedInputStream(new FileInputStream(file));
    	        int fileLen = (int) file.length() - 13;
    	        //skip 13 bytes header
    	        byte[] header = new byte[13];
    	        input.read(header);
    	        log.info("---->Start timestamp:  {}", startTime);
    	        //read frame by frame
    	        while( (bytesTotal < fileLen || flvFrameQueue_.size() > 0 ) && !bCancelCurrentSong.get() && bStarted_.get() ) {
    	        	if( flvFrameQueue_.size() > 0) {
    	        		while ( bStarted_.get() ) {
    	        			FLVFrameObject curFrame = flvFrameQueue_.peek();
    	        			if((curFrame.timestamp - firstPTS_) > ( System.currentTimeMillis() - startTime) ) {
    	        				Thread.sleep( 1 );
    	        			} else {
    	        				break;
    	        			}
    	        		}
    	        		FLVFrameObject curFrame = flvFrameQueue_.remove();
    	        		delegate_.onKaraokeFrameParsed(scope_, curFrame.frame, curFrame.frame.capacity());
    	        		//log.info("---->Popped a frame timestamp:  {}, len {}", curFrame.timestamp, curFrame.frame.capacity());
    	        	}
		    
    	        	if( flvFrameQueue_.size() < 10) {
    	        		//read data
    	        		int bytesRead = readBuf(result, input, bytesTotal, fileLen);
    	        		flvParser_.readData(result, bytesRead); //send to segment parser
    	        		bytesTotal += bytesRead;
    	        		//log.info("Total bytes read:  {}, len {}", bytesTotal, fileLen);
            	        Thread.sleep(1);
    	        	} else {
            	        Thread.sleep(10);
    	        	}
    	        }
    	    } catch (InterruptedException ex) {
    	    	log.info("InterruptedException:  {}", ex);
    	    } catch (Exception ex) {
    	    	log.info("General exception:  {}", ex);
    	    } finally {
    	     	log.info("Closing input stream.");
    	     	input.close();
    	    }
        	//empty the flvFrameQueue
        	if(bCancelCurrentSong.get() && bStarted_.get()) {
    	     	log.info("flvFrameQueue_.size()={}", flvFrameQueue_.size());
    	     	while ( flvFrameQueue_.size() > 0 && bStarted_.get() ) {
    	     		FLVFrameObject curFrame = flvFrameQueue_.peek();
    	     		if((curFrame.timestamp - firstPTS_) > ( System.currentTimeMillis() - startTime) ) {
    	     			Thread.sleep( 1 );
    	     		} else {
    	     			FLVFrameObject frame = flvFrameQueue_.remove();
    	     			delegate_.onKaraokeFrameParsed(scope_, frame.frame, frame.frame.capacity());
    	     			//log.info("---->Finally Popped a frame timestamp:  {}, len {}", curFrame.timestamp, curFrame.frame.capacity());
    	     		}
    	     	}
        	}
        	if( bStarted_.get() ) {
                lastTimestamp_ += 20; //advance a little bit      
        	}
            bCancelCurrentSong.compareAndSet(true, false); //set it back to false;
	    
        }
        catch (FileNotFoundException ex) {
        	log.info("File not found:  {}", ex);
        }
        catch (IOException ex) {
        	log.info("Other exception:  {}", ex);
        }
        catch (Exception ex) {
        	log.info("General exception:  {}", ex);
        } 
    }
    
    @Override
    public void run() {
    	log.info("Karaoke thread is started");
    	//read a segment file and send it over
    	log.info("Reading in karaoke filePath: {}", karaokeFilePath_);
    	while( bStarted_.get() ) {
            delegate_.onVideoPlaying(scope_, curSongName_);
            loadASong(karaokeFilePath_+"/"+curSongFile_+".flv");
    	}

        flvFrameQueue_.clear(); //delete everything.
		lastTimestamp_ = 0;
		firstPTS_ = 0xffffffff;
    	log.info("Karaoke thread is stopped");
    }

    @Override
    public void onKaraokeFrameParsed(ByteBuffer frame, int len, int timestamp) {
    	if( firstPTS_ == 0xffffffff ) {
    	    //send the first frame immediately
    	    firstPTS_ = timestamp;
    	    delegate_.onKaraokeFrameParsed(scope_, frame, len);
    	    log.info("---->First frame timestamp: {} len: {}", firstPTS_, len);
    	} else {
    	    //for the rest, put into the queue first
    	    flvFrameQueue_.add( new FLVFrameObject(frame, len, timestamp) );
    	}
    	lastTimestamp_ = timestamp;
    }
    
    private int readBuf(byte[] result, InputStream input, int bytesTotal, int fileLen) throws IOException {
    	int bytesToRead = 0;
        while(bytesToRead < result.length && (bytesToRead+bytesTotal)<fileLen){
    	    int bytesRemaining = result.length - bytesToRead;
    	    //input.read() returns -1, 0, or more :
    	    int bytesRead = input.read(result, bytesToRead, bytesRemaining); 
    	    if (bytesRead > 0){
    		bytesToRead += bytesRead;
    	    }
        }
        return bytesToRead;
    }
    
    private void readSongMappingTable() {
    	Properties prop = new Properties();
        InputStream in;
    	try {
    	    in = new FileInputStream(karaokeFilePath_ + "/karaoke.properties");
    	    prop.load(in);
    	    Enumeration<?> e = prop.propertyNames();
    	    while (e.hasMoreElements()) {
        		String fileName = (String) e.nextElement();
        		String songName = prop.getProperty(fileName);
        		songMappingTable_.put(songName, fileName);
        		curSongFile_ = fileName;
        		curSongName_ = songName;
        		log.info("-------Reading song property file: Key : {}, Value : {}", fileName, songName);
    	    }
    	    in.close();
    	} catch (FileNotFoundException e) {
    		log.info("-------FileNotFoundException");
    	    e.printStackTrace();
    	} catch (IOException e) {
    		log.info("-------IOException");
    	    e.printStackTrace();
    	}
    }
    
    public void selectVideo(String videoName) {
    	String fileName = songMappingTable_.get(videoName);
    	if(fileName != null ) {
    	    curSongFile_ = fileName;
    	    curSongName_ = videoName;
    	    bCancelCurrentSong.set(true);
    	    log.info("-------A song selected: Key : {}, Value : {}", fileName, videoName);
    	}
    }
    //set next as the default song, an ad for viewing only
    private void nextAsDefaultSong() {
    	curSongFile_ = defaultSong;
    	curSongName_ = defaultSong;
    }

    public void populateVideoList(String streamName){
    	String videoListStr = "";
    	for (Map.Entry<String, String> entry : songMappingTable_.entrySet()) {
    		videoListStr += entry.getKey();
    		videoListStr += ",";
    	}
        delegate_.onVideoListPopulated(scope_, streamName, videoListStr.substring(0, videoListStr.length()-1));
    }
}
