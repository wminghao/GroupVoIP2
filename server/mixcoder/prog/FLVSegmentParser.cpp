#include "FLVSegmentParser.h"
#include "fwk/SmartBuffer.h"
#include "fwk/log.h"
#include "fwk/Units.h"
#include <stdio.h>

bool FLVSegmentParser::readData(SmartPtr<SmartBuffer> input)
{
    u8* data = input->data();
    u32 len = input->dataLength();

    while( len ) {
        switch( parsingState_ ) {
        case SEARCHING_SEGHEADER:
            {
                if ( curBuf_.size() < 4 ) {
                    size_t cpLen = MIN(len, 4-curBuf_.size());
                    curBuf_ += string((const char*)data, cpLen); //concatenate the string                                                                                                                 
                    len -= cpLen;
                    data += cpLen;
                }

                if ( curBuf_.size() >= 4 ) {
                    ASSERT(curBuf_[0] == 'S' && curBuf_[1] == 'G' && curBuf_[2] == 'I');
                    ASSERT(curBuf_[3] == 0); //even layout for now
                    curBuf_.clear();
                    curSegTagSize_ = 0;
                    parsingState_ = SEARCHING_STREAM_MASK;
                }
                break;
            }
        case SEARCHING_STREAM_MASK:
            {
                if ( curBuf_.size() < 4 ) {
                    size_t cpLen = MIN(len, 4-curBuf_.size());
                    curBuf_ += string((const char*)data, cpLen); //concatenate the string                                                                                                          

                    len -= cpLen;
                    data += cpLen;
                }

                if ( curBuf_.size() >= 4 ) {
                    u32 streamMask;
                    memcpy(&streamMask, curBuf_.data(), sizeof(u32));
                    
                    //handle mask here 
                    numStreams_ = count_bits(streamMask);
                    ASSERT(numStreams_ < (u32)MAX_XCODING_INSTANCES);
                    //LOG( "---streamMask=0x%x\r\n", streamMask);
                    int index = 0;
                    while( index < (int)MAX_XCODING_INSTANCES ) {
                        u32 value = ((streamMask<<31)>>31); //mask off all other bits
                        if( value ) {
                            if ( delegate_->getVideoStreamStatus(index) == kStreamOffline  ||
                                 delegate_->getAudioStreamStatus(index) == kStreamOffline) {
                                delegate_->setVideoStreamStatus(kStreamOnlineNotStarted, index);
                                delegate_->setAudioStreamStatus(kStreamOnlineNotStarted, index);
                                LOG( "------->streamMask online  index=%d, numStreams=%d\r\n", index, numStreams_);
                            }
                        } else {
                            //if a stream is changed from online to offline
                            if( delegate_->getVideoStreamStatus(index) != kStreamOffline ||
                                delegate_->getAudioStreamStatus(index) != kStreamOffline) {
                                //recreate everything
                                delete( parser_[index] ); 
                                parser_[index] = new FLVParser(this, index);
                                delegate_->onStreamOffline( index );
                                LOG( "------->streamMask offline index=%d, numStreams=%d\r\n", index, numStreams_);
                            }
                            delegate_->setVideoStreamStatus(kStreamOffline, index);
                            delegate_->setAudioStreamStatus(kStreamOffline, index);
                        }
                        streamMask >>= 1; //shift 1 bit
                        index++;
                    }

                    curStreamCnt_ = numStreams_;
                    curBuf_.clear();
                    curSegTagSize_ = 0;
                    parsingState_ = SEARCHING_STREAM_HEADER;
                }
                break;
            }
        case SEARCHING_STREAM_HEADER:
            {
                if ( curBuf_.size() < 6 ) {
                    size_t cpLen = MIN(len, 6-curBuf_.size());
                    curBuf_ += string((const char*)data, cpLen); //concatenate the string

                    len -= cpLen;
                    data += cpLen;
                }
                if ( curBuf_.size() >= 6 ) {
                    curStreamId_ = (curBuf_[0]&0xf8)>>3; //first 5 bits
                    ASSERT(curStreamId_ < (u32)MAX_XCODING_INSTANCES);

                    u32 curStreamSource = (curBuf_[0]&0x7); //last 3 bits
                    ASSERT( curStreamSource < kTotalStreamSource);
                    ASSERT(curBuf_[1] == 0x0); //ignore the special property

                    memcpy(&curStreamLen_, curBuf_.data()+2, 4); //read the len
                    if( curStreamLen_ > 0 ) {
                        streamSource_[curStreamId_] = (StreamSource)curStreamSource;
                        //LOG( "---curStreamCnt_=%d, curBuf_[0]=0x%x, curStreamId_=%d curStreamSource=%d, curStreamLen_=%d\r\n", curStreamCnt_, curBuf_[0], curStreamId_, curStreamSource, curStreamLen_);
                    }

                    curBuf_.clear();
                    curSegTagSize_ = 0;
                    parsingState_ = SEARCHING_STREAM_DATA;
                }
                break;
            }
        case SEARCHING_STREAM_DATA:
            {
                bool bIsFinished = false;
                if ( curStreamLen_ ) {
                    if ( curBuf_.size() < curStreamLen_ ) {
                        size_t cpLen = MIN(len, curStreamLen_-curBuf_.size());
                        curBuf_ += string((const char*)data, cpLen); //concatenate the string     
                        
                        len -= cpLen;
                        data += cpLen;
                    }
                    if ( curBuf_.size() >= curStreamLen_ ) {
                        //LOG( "---curStreamId_=%d curStreamLen_=%d\r\n", curStreamId_, curStreamLen_);
                        //read the actual buffer
                        SmartPtr<SmartBuffer> curStream = new SmartBuffer( curStreamLen_, curBuf_.data());
                        parser_[curStreamId_]->readData(curStream); 
                        bIsFinished = true;
                    }
                } else {
                    //0 bytes means no data received for this channel even though it's active
                    bIsFinished = true;
                }
                if( bIsFinished ) {
                    curBuf_.clear();
                    curSegTagSize_ = 0;
                    curStreamCnt_--;
                    if ( curStreamCnt_ ) {
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
