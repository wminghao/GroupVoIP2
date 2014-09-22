#include "FLVSegmentParser.h"
#include "fwk/log.h"
#include <assert.h>
#include <stdio.h>
#include "AudioDecoderFactory.h"

const double frameInterval = (double)1000 /(double)OUTPUT_VIDEO_FRAME_RATE;

////////////////////////////////////////////////////////////////
// Audio is always continuous. Video can not be faster than audio.
// There are 3 timestamps to look at.
// 1) frameTimestamp, timestamp of the current frames, 
//                         no bigger than limitTimestamp(MAX of nextBucketTimestamp and audioBucketTimestamp)
// 2) nextBucketTimestamp, in normal case, everytime, bucket advance by 33ms, 
//                         in case there is any video frame within the nextBucket, it's used.
// 3) audioBucketTimestamp, in abnormal case, bucket can advance by multiple of 33ms (audio jumps timestamp ahead)
//                         in case there is no video frame within the nextBucket, it's used.
////////////////////////////////////////////////////////////////
bool FLVSegmentParser::isNextVideoStreamReady(u32& minVideoTimestamp)
{
    minVideoTimestamp = 0xffffffff;
    bool recordFrameTimestamp[MAX_XCODING_INSTANCES];
    memset(recordFrameTimestamp, 0, sizeof(bool)*MAX_XCODING_INSTANCES);

    for(u32 i = 0; i < MAX_XCODING_INSTANCES; i++ ) {
        if ( videoStreamStatus_[i] == kStreamOnlineStarted ) {

            //nextBucketTimestamp is every 33ms since the beginning of video stream
            double nextBucketTimestamp = lastBucketTimestamp_[i] + frameInterval;

            //audioBuckeTimestamp is the bucket under which the audio packet falls into. (strictly folow 33ms rule)
            double audioBucketTimestamp = nextBucketTimestamp; //strictly follow 33ms rule
            if( nextAudioTimestamp_[i] ) {
                audioBucketTimestamp = lastBucketTimestamp_[i] + frameInterval * ((int)(((double)nextAudioTimestamp_[i] - lastBucketTimestamp_[i])/frameInterval)); 
            }

            //nextLimitTimestamp is useful if audio is ahead of video bucket.
            u32 nextLimitTimestamp = MAX( nextBucketTimestamp, audioBucketTimestamp );

            //frame timestamp is the max video timestamp before the limit
            u32 frameTimestamp = MAX_U32;

            //detect if it's an video header
            u32 spsPpsTimestamp = MAX_U32;
            bool hasSpsPps = false;

            if( videoQueue_[i].size() > 0 ) {
                recordFrameTimestamp[i] = true;
                if (isNextVideoFrameSpsPps(i, spsPpsTimestamp)) {
                    hasSpsPps = true;
                    //LOG( "---next is spspps, ts=%d\r\n", spsPpsTimestamp);
                } else {
                    if( hasStarted_[i] ) {
                        //if it's over the limit, don't record
                        if( videoQueue_[i].front()->pts > nextLimitTimestamp ) {
                            recordFrameTimestamp[i] = false;
                        }
                    }
                }
                if( recordFrameTimestamp[i] ) {
                    frameTimestamp = videoQueue_[i].front()->pts;
                }
                //LOG( "---streamMask online available index=%d, next ts=%d, frameTimestamp=%d\r\n", i, videoQueue_[i].front()->pts, frameTimestamp);
            } else {
                //LOG( "---streamMask online unavailable index=%d, numStreams=%d\r\n", i, numStreams_);
            }

            //after the first frame. every 33ms, considers it's ready, regardless whether there is a frame or not
            if( hasStarted_[i] ) {
                if ( frameTimestamp != MAX_U32 ) {
                    if( frameTimestamp <= (u32)nextBucketTimestamp ) { 
                        if( audioBucketTimestamp >= nextBucketTimestamp) {
                            //video has accumulated some data and audio has already catch up
                            nextVideoTimestamp_[i] = lastBucketTimestamp_[i] = nextBucketTimestamp; //strictly follow
                            minVideoTimestamp = MIN(minVideoTimestamp, nextBucketTimestamp); //strictly follow
                            //LOG( "===follow up video timstamp=%d, hasAnyStreamStartedAndReady=%d, audioBucketTimestamp=%d nextBucketTimestamp=%d, lastBucketTimestamp_=%d\r\n", 
                            //   minVideoTimestamp, hasAnyStreamStartedAndReady, (u32)audioBucketTimestamp, (u32)nextBucketTimestamp, (u32)lastBucketTimestamp_);
                        } else {
                            //wait for the nextBucketTimestamp, since audio is not ready yet, not advanced to the next level yet
                            //not ready yet
                            recordFrameTimestamp[i] = false;
                            //LOG( "--not ready. audioBucketTimestamp=%.2f, nextBucketTimestamp=%.2f, minVideoTimestamp=%d\r\n", audioBucketTimestamp, nextBucketTimestamp, minVideoTimestamp);
                        }
                    } else { 
                        assert( audioBucketTimestamp >= frameTimestamp );
                        assert( audioBucketTimestamp > nextBucketTimestamp );
                        //if audio is already ahead, pop that frame out
                        nextVideoTimestamp_[i] = lastBucketTimestamp_[i] = audioBucketTimestamp;
                        minVideoTimestamp  = MIN(minVideoTimestamp, audioBucketTimestamp); //strictly follow
                        //LOG( "===follow up 2 video timstamp=%d, hasAnyStreamStartedAndReady=%d, audioBucketTimestamp=%d nextBucketTimestamp=%d, lastBucketTimestamp_=%d\r\n", 
                        //minVideoTimestamp, hasAnyStreamStartedAndReady, (u32)audioBucketTimestamp, (u32)nextBucketTimestamp, (u32)lastBucketTimestamp_);
                    }
                } else {
                    //no data available
                    //wait for the nextBucketTimestamp
                    //LOG( "--no data available. audioBucketTimestamp=%.2f, nextBucketTimestamp=%.2f, minAudioTimestamp=%d\r\n", audioBucketTimestamp, nextBucketTimestamp, minAudioTimestamp);
                }
            } else {
                if( hasSpsPps ) {
                    //if there is no frame ready, only sps/pps pop out it immediately
                    //LOG( "===found sps pps. but no other frames\r\n");
                    lastBucketTimestamp_[i] = audioBucketTimestamp;
                    nextVideoTimestamp_[i] = spsPpsTimestamp;
                    minVideoTimestamp = MIN(minVideoTimestamp, spsPpsTimestamp); //strictly follow
                } else if ( frameTimestamp != MAX_U32 ) {
                    //first time there is a stream available, always pop out the frame(s)
                    hasStarted_[i] = true;
                    lastBucketTimestamp_[i] = frameTimestamp;
                    nextVideoTimestamp_[i] = frameTimestamp;
                    minVideoTimestamp = MIN(minVideoTimestamp, frameTimestamp); //strictly follow
                    //LOG( "===first video timstamp=%d\r\n", (u32)lastBucketTimestamp_);
                }
            }
        } 
    }

    //isReady means every 33ms, there is at least one video stream ready
    //if none of the video frames are ready, then it's not ready
    bool isReady = false; 
    for(u32 i = 0; i < MAX_XCODING_INSTANCES; i++ ) {
        if( recordFrameTimestamp[i] ) {
            isReady = true;
            break;
        }
    }

    return isReady;
}

//////////////////////////////////////////////////////////////////////////////
//The algorithm to catch up for real time mixing
//   When too many audio frames queued up for a stream happens, 
//   Trim the queue to match the minimum threshold
//////////////////////////////////////////////////////////////////////////////
bool FLVSegmentParser::isNextAudioStreamReady(u32& minAudioTimestamp) {
    minAudioTimestamp = MAX_U32;
    int totalStreams = 0;
    bool isReady = true; //all streams ready means ready

    u32 maxAudioQueueSize = 0;
    u32 minAudioQueueSize = MAX_U32;
    //first calculate maxAudioQueueSize
    for(u32 i = 0; i < MAX_XCODING_INSTANCES; i++ ) {
        if ( audioStreamStatus_[i] == kStreamOnlineStarted ) { 
            maxAudioQueueSize = MAX( maxAudioQueueSize, audioQueue_[i].size());
            minAudioQueueSize = MIN( minAudioQueueSize, audioQueue_[i].size());
        }
    }
        

    if ( maxAudioQueueSize >= LATE_AUDIO_FRAME_THRESHOLD ) {
        assert( minAudioQueueSize != MAX_U32);
        if( maxAudioQueueSize == minAudioQueueSize ) {
            //if all streams comes in a batch mode, reduce it to be 1 to go through
            minAudioQueueSize = 1;
        }
        for(u32 i = 0; i < MAX_XCODING_INSTANCES; i++ ) {
            if ( audioStreamStatus_[i] == kStreamOnlineStarted ) {
                while ( audioQueue_[i].size() > minAudioQueueSize ) {
                    audioQueue_[i].pop();
                }
            }
        }    
        LOG("---------------------------------->Audio stream trimmed, maxAudioQueueSize=%d, minAudioQueueSize=%d!\n", maxAudioQueueSize, minAudioQueueSize);
    }

    //all audio frame rate is the same
    for(u32 i = 0; i < MAX_XCODING_INSTANCES; i++ ) {
        if ( audioStreamStatus_[i] == kStreamOnlineStarted ) { 
            if( audioQueue_[i].size() > 0) {
                nextAudioTimestamp_[i] = audioQueue_[i].front()->pts;
                minAudioTimestamp = MIN( audioQueue_[i].front()->pts, minAudioTimestamp );
            } else {                
                nextAudioTimestamp_[i] = 0; //reset the timestamp to indicate it's missing
                isReady = false;
                //LOG( "---streamMask online unavailable index=%d, numStreams=%d\r\n", i, numStreams_);
                break;
            }   
            totalStreams++;
        }
    }
    return totalStreams?isReady:false;
}

bool FLVSegmentParser::isStreamOnlineStarted(StreamType streamType, int index)
{
    if( streamType == kVideoStreamType ) {
        return ( videoStreamStatus_[index] == kStreamOnlineStarted );
    } else if( streamType == kAudioStreamType ) {
        return ( audioStreamStatus_[index] == kStreamOnlineStarted );
    } else {
        return false;
    }
}

u32 count_bits(u32 n) {     
    unsigned int c; // c accumulates the total bits set in v
    for (c = 0; n; c++) { 
        n &= n - 1; // clear the least significant bit set
    }
    return c;
}

void FLVSegmentParser::onFLVFrameParsed( SmartPtr<AccessUnit> au, int index )
{
    if( au->st == kVideoStreamType ) {
        if( !videoDecoder_[index] )  {
            videoDecoder_[index] = new VideoDecoder(index, au->ctype);
        }
        SmartPtr<VideoRawData> v = new VideoRawData();
        bool bIsValidFrame = videoDecoder_[index]->newAccessUnit(au, v); //decode here
        if( bIsValidFrame ) { //if decoded successfully(it can be an sps pps frame)
            //LOG("------Enqueue video frame, index=%d, queuesize=%d, pts=%d\r\n", index, videoQueue_[index].size(), v->pts);
            videoQueue_[index].push( v );
            videoStreamStatus_[index] = kStreamOnlineStarted;
        }
    } else if ( au->st == kAudioStreamType ) {
        if( !audioDecoder_[index] )  {
            audioDecoder_[index] = AudioDecoderFactory::CreateAudioDecoder(au, index);
        } else {
            if( !AudioDecoderFactory::isSameDecoder(au, audioDecoder_[index]->getAudioInputSetting()) ) {
                delete(audioDecoder_[index]);
                audioDecoder_[index] = AudioDecoderFactory::CreateAudioDecoder(au, index);
                //LOG("-----------brand new audio, different setting!!!!!\r\n");
            }
        }
        u32 origPts = au->pts;
        audioDecoder_[index]->newAccessUnit(au, &rawAudioSettings_); //decode here

        bool hasAnyDataPoppedOut = false;
        //read a couple of 1152 samples/frame here
        while(audioDecoder_[index]->isNextRawMp3FrameReady() ) {
            SmartPtr<AudioRawData> a = new AudioRawData();
            bool bIsStereo = false;
            a->rawAudioFrame_ = audioDecoder_[index]->getNextRawMp3Frame(bIsStereo);
            a->bIsStereo = bIsStereo;
            a->pts = audioTsMapper_[index].getNextTimestamp( origPts ); 
            //LOG("-----------After resampling, pts=%d to %d, isStereo=%d\r\n", au->pts, a->pts, a->bIsStereo);
            audioQueue_[index].push( a );
            globalAudioTimestamp_ = a->pts; //global audio timestamp updated here
            hasAnyDataPoppedOut = true;
        }
        if( hasAnyDataPoppedOut && kStreamOnlineNotStarted == audioStreamStatus_[index] ) {
            audioStreamStatus_[index] = kStreamOnlineStarted;
        }
    } else {
        //do nothing
    }
}

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
                    assert(curBuf_[0] == 'S' && curBuf_[1] == 'G' && curBuf_[2] == 'I');
                    assert(curBuf_[3] == 0); //even layout for now
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
                    assert(numStreams_ < (u32)MAX_XCODING_INSTANCES);
                    //LOG( "---streamMask=0x%x\r\n", streamMask);
                    int index = 0;
                    while( index < (int)MAX_XCODING_INSTANCES ) {
                        u32 value = ((streamMask<<31)>>31); //mask off all other bits
                        if( value ) {
                            if ( videoStreamStatus_[index] == kStreamOffline  ||
                                 audioStreamStatus_[index] == kStreamOffline) {
                                videoStreamStatus_[index] = kStreamOnlineNotStarted;
                                audioStreamStatus_[index] = kStreamOnlineNotStarted;
                                LOG( "------->streamMask online  index=%d, numStreams=%d\r\n", index, numStreams_);
                            }
                        } else {
                            //if a stream is changed from online to offline
                            if( videoStreamStatus_[index] != kStreamOffline ||
                                audioStreamStatus_[index] != kStreamOffline) {
                                //recreate everything
                                delete( parser_[index] ); 
                                parser_[index] = new FLVParser(this, index);
                                delete( audioDecoder_[index] );
                                audioDecoder_[index] = NULL; //initialize it later
                                delete( videoDecoder_[index] );
                                videoDecoder_[index] = NULL; //initialize it later
                                audioTsMapper_[index].reset();
                                nextAudioTimestamp_[index] = 0;
                                nextVideoTimestamp_[index] = 0;
                                lastBucketTimestamp_[index] = 0;
                                hasStarted_[index] = 0;
                                LOG( "------->streamMask offline index=%d, numStreams=%d\r\n", index, numStreams_);
                            }
                            videoStreamStatus_[index] = kStreamOffline;
                            audioStreamStatus_[index] = kStreamOffline;
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
                    assert(curStreamId_ < (u32)MAX_XCODING_INSTANCES);

                    u32 curStreamSource = (curBuf_[0]&0x7); //last 3 bits
                    assert( curStreamSource < kTotalStreamSource);
                    streamSource[curStreamId_] = (StreamSource)curStreamSource;

                    assert(curBuf_[1] == 0x0); //ignore the special property

                    memcpy(&curStreamLen_, curBuf_.data()+2, 4); //read the len
                    //LOG( "---curStreamCnt_=%d, curBuf_[0]=0x%x, curStreamId_=%d curStreamSource=%d, curStreamLen_=%d\r\n", curStreamCnt_, curBuf_[0], curStreamId_, curStreamSource, curStreamLen_);

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

bool FLVSegmentParser::isNextVideoFrameSpsPps(u32 index, u32& timestamp)
{
    bool bIsSpsPps = false;
    if ( videoQueue_[index].size() > 0 ) {
        SmartPtr<VideoRawData> v = videoQueue_[index].front();
        if ( v && v->sp == kSpsPps ) {
            bIsSpsPps = true;
            timestamp = v->pts;
        }
    }
    return bIsSpsPps;
}

//can return more than 1 frome
SmartPtr<VideoRawData> FLVSegmentParser::getNextVideoFrame(u32 index)
{
    SmartPtr<VideoRawData> v;
    if ( videoQueue_[index].size() > 0 ) {
        u32 timestamp = nextVideoTimestamp_[index];
        v = videoQueue_[index].front();
        if ( v && v->pts <= timestamp ) {
            videoQueue_[index].pop();
            if( videoQueue_[index].back() ) {
                LOG("------pop next video frame, index=%d cur_pts=%d last_pts=%d queue=%d\r\n", index, v->pts, videoQueue_[index].back()->pts, videoQueue_[index].size());
            } else {
                LOG("------pop next video frame, index=%d cur_pts=%d last_pts=%d queue=%d\r\n", index, v->pts, 0, videoQueue_[index].size());
            }
        } else {
            //LOG("------nopop Next video frame, index=%d queue=%d\r\n", index, videoQueue_[index].size());
            //don't pop anything that has a bigger timestamp
            v = NULL;
        }
    }
    return v;
}

SmartPtr<AudioRawData> FLVSegmentParser::getNextAudioFrame(u32 index)
{
    SmartPtr<AudioRawData> a;
    if ( audioQueue_[index].size() > 0 ) {
        a = audioQueue_[index].front();
        if ( a ) {
            audioQueue_[index].pop();
            
            if( audioQueue_[index].back() ) {
                LOG("------pop next audio frame, index=%d cur_pts=%d last_pts=%d queue=%d\r\n", index, a->pts, audioQueue_[index].back()->pts, audioQueue_[index].size());
            } else {
                LOG("------pop next audio frame, index=%d cur_pts=%d last_pts=%d queue=%d\r\n", index, a->pts, 0, audioQueue_[index].size());
            }
        }
    }
    return a;
}
