package org.red5.server.mixer;

import java.io.BufferedOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.ByteBuffer;

import org.red5.logging.Red5LoggerFactory;
import org.red5.server.api.Red5;
import org.slf4j.Logger;

public class SegmentArchiver {
    private OutputStream outputFile_ = null;
    private static Logger log = Red5LoggerFactory.getLogger(Red5.class);
    
    public SegmentArchiver(String outputFilePath, String scopeName) {
		try {
		    //log.info("=====>Writing binary file... outputFile={}", this.outputFilePath);
		    if( outputFile_ == null ) {
		    	String filePath = outputFilePath+"segment_"+scopeName+".seg";
            	outputFile_ = new BufferedOutputStream(new FileOutputStream(filePath));
		    }
		}
		catch(FileNotFoundException ex){
		    log.info("======>Output File not found.");
		}
    }
    
    public void write(ByteBuffer seg ){
    	try {
		    //log.info("=====>Writing binary file... outputFile={}", this.outputFilePath);
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
    public void close() {
	    try {
	    	if( outputFile_ != null ) {
	    		outputFile_.close();
	    		outputFile_ = null;
	    	}
	    }catch (IOException ex) {
	    	log.info("close exception:  {}", ex);
    	}
    }
}
