package org.red5.server.mixer;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;

import org.red5.logging.Red5LoggerFactory;
import org.red5.server.api.Red5;
import org.red5.server.api.scope.IScope;
import org.slf4j.Logger;

class SegmentParser
{
    public interface Delegate {
        public void onFrameParsed(IScope scope, int mixerId, ByteBuffer frame, int len);
    }
    
    public SegmentParser(Delegate delegate, IScope scope) {
    	this.delegate = delegate;
    	this.scope_ = scope;
    
    	// to use little endian
    	curBuf_.order(ByteOrder.LITTLE_ENDIAN);
    }
    private Delegate delegate;
    private IScope scope_ = null;
    private static Logger log = Red5LoggerFactory.getLogger(Red5.class);
	
    private int count_bits(int n) {
    	int c; // c accumulates the total bits set in v
    	for (c = 0; n!=0; c++) {
    		n &= n - 1; // clear the least significant bit set
    	}
    	return c;
    }
    private static final int MAX_XCODING_INSTANCES = 32;
    
    //segment parsing state
    private static final int SEARCHING_SEGHEADER = 0;
    private static final int SEARCHING_STREAM_MASK = 1;
    private static final int SEARCHING_STREAM_HEADER = 2;
    private static final int SEARCHING_STREAM_DATA = 3;
    
    private int parsingState_ = SEARCHING_SEGHEADER;
    private ByteBuffer curBuf_ = ByteBuffer.allocate(1<<20); //1 Meg of memory
    private int curLen_ = 0;
    private int curStreamId_ = 0;
    private int curStreamLen_ = 0;
    private int curStreamCnt_ = 0;
    private boolean curStreamIsVideo_ = false;
    private int numStreams_ = 0;
    
    //allinonestream backup
    private ByteBuffer allInOneBuf_ = ByteBuffer.allocate(1<<20); //1 Meg of memory
    private int allInOneBufLen_ = 0;
    
    boolean readData(byte[] src, int srcLen)
    {
    	int srcIndex = 0; //index into data byte array
        while( srcLen > 0 ) {
            switch( parsingState_ ) {
            case SEARCHING_SEGHEADER:
                {
                    if ( curLen_ < 3 ) {
                        int cpLen = Math.min(srcLen, 3-curLen_);
                        curBuf_.put(src, srcIndex, cpLen); //concatenate the string                                                                                                                 
                        srcLen -= cpLen;
                        srcIndex += cpLen; //advance
                        curLen_+=cpLen;
                    }

                    if ( curLen_ >= 3 ) {
                        assert(curBuf_.array()[0] == 'S' && curBuf_.array()[1] == 'G' && curBuf_.array()[2] == 'O');

                        //System.out.println("---Read SGO header, len="+curLen_);
                        curBuf_.clear();
                        curLen_ = 0;
                        parsingState_ = SEARCHING_STREAM_MASK;
                    }
                    break;
                }
            case SEARCHING_STREAM_MASK:
                {
                    if ( curLen_ < 5 ) {
                        int cpLen = Math.min(srcLen, 5-curLen_);
                        curBuf_.put(src, srcIndex, cpLen); //concatenate the string
                        srcLen -= cpLen;
                        srcIndex += cpLen; //advance
                        curLen_+=cpLen;
                    }

                    if ( curLen_ >= 5 ) {
                    	curBuf_.flip();
                        int streamMask = curBuf_.getInt();
                        curStreamIsVideo_ = curBuf_.get() == 0x01; //1 means video stream
                        
                        //handle mask here 
                        numStreams_ = count_bits(streamMask)+1;
                        assert(numStreams_ < MAX_XCODING_INSTANCES);
                        
                        //log.info("---streamMask={} numStreams_={}, curStreamIsVideo_={}", streamMask, numStreams_, curStreamIsVideo_);
                        //System.out.println("---streamMask="+streamMask+" numStreams_="+numStreams_);
                        int index = 0;
                        while( streamMask !=0 ) {
                            int value = ((streamMask<<31)>>31); //mask off all other bits
                            if( value!=0 ) {
                            	//log.info("---streamMask index={} is valid.", index);
                            	//System.out.println("---streamMask index="+index+" is valid.");
                            }
                            streamMask >>= 1; //shift 1 bit
                            index++;
                        }

                        curStreamCnt_ = numStreams_;
                        curBuf_.clear();
                        curLen_ = 0;
                        parsingState_ = SEARCHING_STREAM_HEADER;
                    }
                    break;
                }
            case SEARCHING_STREAM_HEADER:
                {
                    if ( curLen_ < 5 ) {
                        int cpLen = Math.min(srcLen, 5-curLen_);
                        curBuf_.put(src, srcIndex, cpLen);//concatenate the string
                        srcLen -= cpLen;
                        srcIndex += cpLen;
                        curLen_+=cpLen;
                    }
                    if ( curLen_ >= 5 ) {
                    	curBuf_.flip();
                        curStreamId_ = curBuf_.get();
                        assert(curStreamId_ <= MAX_XCODING_INSTANCES);    
                    	curStreamLen_ = curBuf_.getInt();
                    	//log.info("---curBuf_[0]={}, curStreamId_={}, len={}\r\n", curBuf_.array()[0], curStreamId_, curStreamLen_);                    
                    	//System.out.println("---curBuf_[0]="+curBuf_.array()[0]+", curStreamId_="+curStreamId_ + " curStreamLen_="+ curStreamLen_);
                    	curBuf_.clear();
                    	curLen_ = 0;		
                    	parsingState_ = SEARCHING_STREAM_DATA;
                    }
                    break;
                }
            case SEARCHING_STREAM_DATA:
                {
                    if ( curLen_ < curStreamLen_ ) {
                        int cpLen = Math.min(srcLen, curStreamLen_-curLen_);
                        curBuf_.put(src, srcIndex, cpLen); //concatenate the string     
                                      
                        srcLen -= cpLen;
                        srcIndex += cpLen;
                        curLen_+=cpLen;
                    }
                    if ( curLen_ >= curStreamLen_ ) {
                    	//log.info("---curStreamId_={} curStreamLen_={} curStreamCnt_={} curStreamIsVideo_={} ", curStreamId_, curStreamLen_, curStreamCnt_, curStreamIsVideo_);
                    	//System.out.println("---curStreamId_="+curStreamId_+" curStreamLen_="+curStreamLen_);
                        
                    	if( curStreamIsVideo_ ) {
                            if( curStreamId_ == MAX_XCODING_INSTANCES ) {
                            	//read the actual buffer
                            	if( curStreamLen_ > 0 ) {
                            		curBuf_.flip();
                            		delegate.onFrameParsed(scope_, curStreamId_, curBuf_, curStreamLen_); 
                            	}
                            	//log.info("---backup allinone curStreamId_={}, len={}\r\n", curStreamId_, curStreamLen_);
                            	//make a copy of Allinone buffer
                            	allInOneBuf_.clear();
                            	allInOneBuf_.put(curBuf_.array(), 0, curStreamLen_);
                            	allInOneBufLen_ = curStreamLen_;
                            	allInOneBuf_.flip();
                            } else {
                            	//it's ditto stream for any stream that's not all-in-one.
                            	if( curStreamLen_ != 1 ) {
                            		assert( curStreamLen_ > 1 );
                                	//it's ditto+cuepoint, read the cuepoint
                            		 if( curStreamLen_ > 1 ) {
                            			 curBuf_.flip();
                            			 delegate.onFrameParsed(scope_, curStreamId_, curBuf_, curStreamLen_-1); 
                                    	 //log.info("---indirect copy of metadata curBuf_[0]={}, curStreamId_={}, len={}\r\n", curBuf_.array()[0], curStreamId_, curStreamLen_-1);
                                     }
                            	}
                            	//it's ditto, repeat the same buffer as previous stream
                                if( allInOneBufLen_ > 0 ) {
                                	//log.info("---direct copy of allinone curBuf_[0]={}, curStreamId_={}, len={} allInOneBufLen_={}\r\n", curBuf_.array()[0], curStreamId_, curStreamLen_, allInOneBufLen_);
                                    delegate.onFrameParsed(scope_, curStreamId_, allInOneBuf_, allInOneBufLen_); 
                                	allInOneBuf_.flip();
                                }
                            }
                    	} else { //for audio frames
                        	//read the actual buffer
                        	if( curStreamLen_ > 0 ) {
                        		curBuf_.flip();
                        		delegate.onFrameParsed(scope_, curStreamId_, curBuf_, curStreamLen_); 
                        	}
                    	}
                    	curBuf_.clear();
                        curLen_ = 0;
                        curStreamCnt_--;
                        if ( curStreamCnt_ > 0 ) {
                            parsingState_ = SEARCHING_STREAM_HEADER;
                        } else {
                            parsingState_ = SEARCHING_SEGHEADER;
                        }
                    }
                    break;
                }
            }
        }
        return true;
    }    
}
