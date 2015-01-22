package org.red5.server.mixer;

import java.io.BufferedOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.ByteBuffer;

import org.red5.logging.Red5LoggerFactory;
import org.red5.server.api.Red5;
import org.red5.server.api.scope.IScope;
import org.slf4j.Logger;

public class FLVArchiver {
	private String archivePrefix_;
	private String scopeName_;
    private OutputStream outputFile_ = null;
    private static Logger log = Red5LoggerFactory.getLogger(Red5.class);
    
	public FLVArchiver(String archivePath, String scopeName) {
		archivePrefix_ = archivePath;
		scopeName_ = scopeName;
	}
	public void startArchive() {
		try {
		    //log.info("=====>Writing binary file... outputFile={}", this.outputFilePath);
		    if( outputFile_ == null ) {
		    	String filePath = archivePrefix_+"archive_"+scopeName_+".flv";
            	outputFile_ = new BufferedOutputStream(new FileOutputStream(filePath));
		    }
		    if( outputFile_ != null ) {
    			//13 bytes flv header
    			outputFile_.write('F');
    			outputFile_.write('L');
    			outputFile_.write('V');
    			outputFile_.write(0x1);
    			outputFile_.write(0x5);
    			outputFile_.write(0);
    			outputFile_.write(0);
    			outputFile_.write(0);
    			outputFile_.write(0x9);
    			outputFile_.write(0);
    			outputFile_.write(0);
    			outputFile_.write(0);
    			outputFile_.write(0);
		    }
		}
		catch(FileNotFoundException ex){
		    log.info("======>Output flv File not found.");
		}
		catch(IOException ex){
		    log.info("======>IO flv exception.");
		}
	}
	public void stopArchive() {
		try {
	    	outputFile_.close();
	    	outputFile_ = null;
	    }catch (IOException ex) {
	    	log.info("close flv exception:  {}", ex);
    	}
	}
	public void archiveData(ByteBuffer frame, int startOffset, int flvFrameLen) {
	    try {
			outputFile_.write(frame.array(), startOffset, flvFrameLen-startOffset);
		} catch (IOException e) {
	    	log.info("flv write exception:  {}", e);
		}
	}
}
