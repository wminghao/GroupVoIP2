package org.red5.server.mixer;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.ByteBuffer;

import org.apache.mina.core.buffer.IoBuffer;
import org.red5.logging.Red5LoggerFactory;
import org.red5.server.api.Red5;
import org.slf4j.Logger;

public class NativeProcessPipe implements SegmentParser.Delegate, MixCoderBridge.Delegate {
    private boolean bLoadFromDisc = false; //read from a file instead
    private boolean bSaveToDisc = false; //log input file to a disc
    private static Logger log = Red5LoggerFactory.getLogger(Red5.class);
    
    //test only
    private String inputFilePath;
    private String outputFilePath;
    private OutputStream outputFile_ = null;
    private DiscReaderThread discReaderThread_ = null;
    private boolean bStartDiscReader = false;
    
    /*
     * flv output segment parser
     */
    private SegmentParser segParser_ = new SegmentParser(this);
    private SegmentParser.Delegate delegate;
    private MixCoderBridge mixCoderBridge = null;
    private int procId = -1;
    
    public NativeProcessPipe(SegmentParser.Delegate delegate, MixCoderBridge mixCoderBridge, boolean bSaveToDisc, String outputFilePath, boolean bLoadFromDisc, String inputFilePath)
    {
    	this.delegate = delegate;
    	this.mixCoderBridge = mixCoderBridge;
    	this.bSaveToDisc = bSaveToDisc;
    	this.outputFilePath = outputFilePath;
    	this.bLoadFromDisc = bLoadFromDisc;
    	this.inputFilePath = inputFilePath;
    	log.info("======>GroupMixer configuration, bSaveToDisc={}, outPath={}, bLoadFromDisc={}, inPath={}, procId={}.", bSaveToDisc, outputFilePath, bLoadFromDisc, inputFilePath, procId);
    }
    
    public void handleSegInput(IdLookup idLookupTable, String streamName, int msgType, IoBuffer buf, int eventTime)
    {
    	int dataLen = buf.limit();
    	if( dataLen > 0 ) {
    	    InputObject inputObject = new InputObject(idLookupTable, streamName, msgType, buf, eventTime, dataLen);
    	    ByteBuffer seg = inputObject.toByteBuffer();
    
    	    if(bSaveToDisc) {
        		try {
        		    //log.info("=====>Writing binary file... outputFile={}", this.outputFilePath);
        		    if( outputFile_ == null ) {
                    	outputFile_ = new BufferedOutputStream(new FileOutputStream(this.outputFilePath));
        		    }
        		    if( outputFile_ != null ) {
            			if( seg != null ) {
            			    //log.info("=====>array totalLen={} size={}", totalLen, seg.array().length);
            			    outputFile_.write(seg.array(), 0, seg.array().length);
            			}
        		    }
        		}
        		catch(FileNotFoundException ex){
        		    log.info("======>Output File not found.");
        		}
        		catch(IOException ex){
        		    log.info("======>IO exception.");
        		}
    	    } 
    	    if ( bLoadFromDisc ) {
        		try {
        		    if ( discReaderThread_ == null ) {
        		    	bStartDiscReader = true;
            			//start the thread here
            			discReaderThread_ = new DiscReaderThread();
            			Thread thread = new Thread(discReaderThread_, "DiscReader");
            			thread.start();
        		    }
        		} catch (Exception ex) {
        		    log.info("=====>Disc IO other exception:  {}", ex);
        		}			
    	    } else {
    	    	//call native C function send it to an array
    	    	mixCoderBridge.sendInput(seg.array(), seg.limit(), procId);
    	    }
    	}
    }
    
    //callback from native C code.
    public void newOutput(byte[] bytesRead, int len) {
    	segParser_.readData(bytesRead, len); //send to segment parser
    }
    
    class DiscReaderThread implements Runnable {
    	@Override
    	public void run() {
    	    log.info("Thread is started");
    	    assert( bLoadFromDisc );
    	    //read a segment file and send it over
    	    log.info("Reading in binary file named : {}", inputFilePath);
    	    File file = new File(inputFilePath);
    	    log.info("File size: {}", file.length());
    	    try {
    	    	InputStream input = null;
    	    	try {
        		    int bytesTotal = 0;
        		    byte[] result = new byte[4096];
        		    input = new BufferedInputStream(new FileInputStream(file));
        		    int fileLen = (int) file.length();
        		    while( bStartDiscReader && bytesTotal < fileLen ) {
        		    	int bytesToRead = 0;
                    	while(bStartDiscReader && bytesToRead < result.length && (bytesToRead+bytesTotal)<fileLen){
            			    int bytesRemaining = result.length - bytesToRead;
            			    //input.read() returns -1, 0, or more :
            			    int bytesRead = input.read(result, bytesToRead, bytesRemaining); 
            			    if (bytesRead > 0){
            			    	bytesToRead += bytesRead;
            			    }
                    	}
                    	if( bStartDiscReader ) {
                    		//Input segment
                    		mixCoderBridge.sendInput(result, bytesToRead, procId);
                    		//Output segment
                    		//segParser_.readData(result, bytesToRead); //send to segment parser
                    		bytesTotal += bytesToRead;
                    		Thread.sleep(20);

                    		//log.info("Total bytes read:  {}, len {}", bytesTotal, fileLen);
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
        	 }
        	 catch (FileNotFoundException ex) {
        		log.info("File not found:  {}", ex);
        	 }
        	 catch (IOException ex) {
        		log.info("Other exception:  {}", ex);
        	 }
    	}
    }
    
    @Override
    public void onFrameParsed(int mixerId, ByteBuffer frame, int len) {
    	this.delegate.onFrameParsed(mixerId, frame, len);		
    }	
    
    public boolean open()
    {
    	procId = mixCoderBridge.newProc(this);
		log.info("mixCoderBridge opened:  {}", procId);
		return procId != -1;
    }
    
    public void close()
    {
    	if( bSaveToDisc ) {
    	    try {
    	    	outputFile_.close();
    	    	outputFile_ = null;
    	    }catch (IOException ex) {
    	    	log.info("close exception:  {}", ex);
        	}
    	}
    	
    	if ( !bLoadFromDisc ) {
    	    //close native c lib.
    	    mixCoderBridge.delProc(procId);
    		log.info("mixCoderBridge closed:  {}", procId);
    	} else {
    		bStartDiscReader = false;
    	}
    }
}
