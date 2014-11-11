#include "FLVSegmentInput.h"
#include "fwk/log.h"
#include "fwk/Units.h"
#include <stdio.h>
#include <math.h>
#include "AudioDecoderFactory.h"
#include "AudioMixer.h"

const u32 MAX_VIDEO_QUEUE_SIZE = 30; //max of 30 frames per queue size

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
bool FLVSegmentInput::isNextVideoStreamReady(u32& maxVideoTimestamp)
{
    //isReady means every 33ms, there is at least one video stream ready
    //if none of the video frames are ready, then it's not ready
    bool isReady = false; 
    maxVideoTimestamp = 0;

    for(u32 i = 0; i < MAX_XCODING_INSTANCES; i++ ) {
        if ( videoStreamStatus_[i] == kStreamOnlineStarted ) {

            //nextBucketTimestamp is every 33ms since the beginning of video stream
            double nextBucketTimestamp = lastBucketTimestamp_[i] + videoFrameIntervalInMs;

            //audioBuckeTimestamp is the bucket under which the audio packet falls into. (strictly folow 33ms rule)
            double audioBucketTimestamp = nextBucketTimestamp; //strictly follow 33ms rule
            if( nextAudioTimestamp_[i] ) {
                audioBucketTimestamp = lastBucketTimestamp_[i] + videoFrameIntervalInMs * ((int)(((double)nextAudioTimestamp_[i] - lastBucketTimestamp_[i])/videoFrameIntervalInMs)); 
            }

            //nextLimitTimestamp is useful if audio is way ahead of video bucket.
            u32 nextLimitTimestamp = MAX( nextBucketTimestamp, audioBucketTimestamp );

            //frame timestamp is the max video timestamp before the limit
            u32 frameTimestamp = MAX_U32;

            //detect if it's an video header
            u32 spsPpsTimestamp = MAX_U32;
            bool hasSpsPps = false;

            bool recordFrameTimestamp = false;

            if( videoQueue_[i].size() > 0 ) {
                recordFrameTimestamp = true;
                if (isNextVideoFrameSpsPps(i, spsPpsTimestamp)) {
                    hasSpsPps = true;
                    //LOG( "---next is spspps, ts=%d\r\n", spsPpsTimestamp);
                } else {
                    if( hasStarted_[i] ) {
                        //if it's over the limit, don't record
                        if( videoQueue_[i].front()->pts > nextLimitTimestamp ) {
                            recordFrameTimestamp = false;
                        }
                    }
                }
                if( recordFrameTimestamp ) {
                    isReady = true;
                    frameTimestamp = videoQueue_[i].front()->pts;
                }
                //LOG( "---streamMask online available index=%d, next ts=%d, frameTimestamp=%d\r\n", i, videoQueue_[i].front()->pts, frameTimestamp);
            } else {
                //LOG( "---streamMask online unavailable index=%d, numStreams=%d\r\n", i, numStreams_);
            }

            //Total of 6 cases
            //after the first frame. every 33ms, considers it's ready, regardless whether there is a frame or not
            if( hasStarted_[i] ) {
                if ( frameTimestamp != MAX_U32 ) {
                    if( frameTimestamp <= (u32)nextBucketTimestamp ) { 
                        if( audioBucketTimestamp >= nextBucketTimestamp) {
                            //////////////////////////////////////////////////////////////////////////////////////////////////////
                            //Case 1. frameTimestamp <= nextBucketTimestamp <= audioBucketTimestamp 
                            //////////////////////////////////////////////////////////////////////////////////////////////////////
                            //video has accumulated some data and audio has already catch up
                            nextVideoTimestamp_[i] = momentoBucketTimestamp_[i] = nextBucketTimestamp; //strictly follow
                            maxVideoTimestamp = MAX(maxVideoTimestamp, nextBucketTimestamp); //strictly follow
                            //LOG( "===stream: %d follow up video timstamp=%d, audioBucketTimestamp=%d nextBucketTimestamp=%d\r\n", i, maxVideoTimestamp, (u32)audioBucketTimestamp, (u32)nextBucketTimestamp);
                        } else {
                            ASSERT(audioBucketTimestamp < nextBucketTimestamp);
                            //wait for the nextBucketTimestamp, since audio is not ready yet, not advanced to the next level yet
                            if( frameTimestamp <= audioBucketTimestamp ) {
                                //////////////////////////////////////////////////////////////////////////////////////////////////////
                                //Case 2. frameTimestamp <= audioBucketTimestamp < nextBucketTimestamp
                                //////////////////////////////////////////////////////////////////////////////////////////////////////
                                //audio not ready yet, but video can pop out,
                                nextVideoTimestamp_[i] = audioBucketTimestamp;
                                //dont advance lastBucketTimestamp_[i]
                                maxVideoTimestamp = MAX(maxVideoTimestamp, audioBucketTimestamp );
                                //LOG( "===stream:%d audio not ready. frameTimestamp=%d, audioBucketTimestamp=%.2f, nextBucketTimestamp=%.2f, maxVideoTimestamp=%d\r\n", i, frameTimestamp, audioBucketTimestamp, nextBucketTimestamp, maxVideoTimestamp);
                            } else {
                                //////////////////////////////////////////////////////////////////////////////////////////////////////
                                //Case 3. audioBucketTimestamp < frameTimestamp <= nextBucketTimestamp
                                //////////////////////////////////////////////////////////////////////////////////////////////////////
                                //audio may or may not be ready yet, but video can pop out,
                                nextVideoTimestamp_[i] = frameTimestamp;
                                //dont advance lastBucketTimestamp_[i]
                                maxVideoTimestamp = MAX(maxVideoTimestamp, frameTimestamp); 
                                //LOG( "===stream:%d audio may be ready, give it a try. frameTimestamp=%d, audioBucketTimestamp=%.2f, nextBucketTimestamp=%.2f, maxVideoTimestamp=%d\r\n", i, frameTimestamp, audioBucketTimestamp, nextBucketTimestamp, maxVideoTimestamp);
                            }
                        }
                    } else { 
                        //////////////////////////////////////////////////////////////////////////////////////////////////////
                        //Case 4. nextBucketTimestamp < frameTimestamp <= audioBucketTimestamp 
                        //////////////////////////////////////////////////////////////////////////////////////////////////////
                        ////frameTimestamp > nextBucketTimestamp 
                        ASSERT( audioBucketTimestamp >= frameTimestamp );
                        ASSERT( audioBucketTimestamp > nextBucketTimestamp );
                        //if audio is already ahead, pop that frame out, jump forward
                        nextVideoTimestamp_[i] = momentoBucketTimestamp_[i] = audioBucketTimestamp;
                        maxVideoTimestamp  = MAX(maxVideoTimestamp, audioBucketTimestamp); //strictly follow
                        //LOG( "===stream:%d follow up 2 video timstamp=%d, audioBucketTimestamp=%d nextBucketTimestamp=%d\r\n", i, maxVideoTimestamp, (u32)audioBucketTimestamp, (u32)nextBucketTimestamp);
                    }
                } else {
                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                    //Case 5 & 6. frameTimestamp > MAX( audioBucketTimestamp, nextBucketTimestamp )
                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                    //no data available
                    //wait for the nextBucketTimestamp
                    //LOG( "===stream:%d no data available. audioBucketTimestamp=%.2f, nextBucketTimestamp=%.2f, maxVideoTimestamp=%d\r\n", i, audioBucketTimestamp, nextBucketTimestamp, maxVideoTimestamp);
                }
            } else {
                if( hasSpsPps ) {
                    //if there is no frame ready, only sps/pps pop out it immediately
                    //LOG( "===stream:%d found sps pps. but no other frames\r\n", i);
                    momentoBucketTimestamp_[i] = audioBucketTimestamp;
                    nextVideoTimestamp_[i] = spsPpsTimestamp;
                    maxVideoTimestamp = MAX(maxVideoTimestamp, spsPpsTimestamp); //strictly follow
                } else if ( frameTimestamp != MAX_U32 ) {
                    //first time there is a stream available, always pop out the frame(s)
                    hasStarted_[i] = true;
                    momentoBucketTimestamp_[i] = frameTimestamp;
                    nextVideoTimestamp_[i] = frameTimestamp;
                    maxVideoTimestamp = MAX(maxVideoTimestamp, frameTimestamp); //strictly follow
                    //LOG( "===stream:%d first video timestamp=%d\r\n", i, frameTimestamp);
                }
            }
        } 
    }

    return isReady;
}

void FLVSegmentInput::calcQueueSize(u32& maxAudioQueueSize, u32&minAudioQueueSize)
{
    maxAudioQueueSize = 0;
    minAudioQueueSize = MAX_U32;

    for(u32 i = 0; i < MAX_XCODING_INSTANCES; i++ ) {
        if ( audioStreamStatus_[i] == kStreamOnlineStarted ) { 
            maxAudioQueueSize = MAX( maxAudioQueueSize, audioQueue_[i].size());
            minAudioQueueSize = MIN( minAudioQueueSize, audioQueue_[i].size());
        }
    }    
}

void FLVSegmentInput::printQueueInfo(int i)
{
    for(list<SmartPtr<AudioRawData> >::const_iterator ci = audioQueue_[i].begin(); ci != audioQueue_[i].end(); ++ci) {
        SmartPtr<AudioRawData> a = *ci;
        LOG("---Audio Queue: %d traversal ts=%d, size=%d", i, a->pts, a->rawAudioFrame_->dataLength());
    }
}

void FLVSegmentInput::printQueueSize()
{
    for(u32 i = 0; i < MAX_XCODING_INSTANCES; i++ ) {
        if ( audioStreamStatus_[i] == kStreamOnlineStarted ) {
            LOG("----Queue %d size=%d", i, audioQueue_[i].size());
        }
    }
}

const u64 MP3_FRAME_MAX_GAP_IN_MS = ((u64)MP3_FRAME_INTERVAL_IN_MS * 3)/2;

//////////////////////////////////////////////////////////////////////////////
//The algorithm to catch up for real time mixing
//  When too many audio frames queued up for a stream happens, 
//Below is the algorithm to throw away frames if the queue is too large.
//2 cases, 
//  1) frames from different streams come in different speed, comes in batch mode
//  2) timestamp jumped, (frames thrown away from the source)
//Case 1) we trim the queue to match the minimum threshold
//Case 2) we just catch up by mixing with prev frame for that stream
//////////////////////////////////////////////////////////////////////////////
bool FLVSegmentInput::isNextAudioStreamReady(u32& maxAudioTimestamp) {
    maxAudioTimestamp = 0;
    int totalStreams = 0;
    bool isReady = true; //all streams ready means ready

    u32 maxAudioQueueSize = 0;
    u32 minAudioQueueSize = MAX_U32;

    //first calculate maxAudioQueueSize
    calcQueueSize(maxAudioQueueSize, minAudioQueueSize);
        
    //For case 1), we handle it by trimming its queue when a stream has frames comes in batch mode.
    if ( maxAudioQueueSize >= MAX_LATE_AUDIO_FRAME_THRESHOLD ) {
        ASSERT( minAudioQueueSize != MAX_U32);
        LOG("---------->Audio stream needs to be trimmed, elapsedTime=%dms", (getEpocTime() - lastAudioPopoutTime_ ));
        //reduce it by half to go through
        //printQueueSize();

        for(u32 i = 0; i < MAX_XCODING_INSTANCES; i++ ) {
            if ( audioStreamStatus_[i] == kStreamOnlineStarted ) {
                if ( audioQueue_[i].size() >= MAX_LATE_AUDIO_FRAME_THRESHOLD ) {
                    LOG("---------->Before audio stream %d trimmed, audioQueue_[i].size()=%d, maxAudioQueueSize=%d, minAudioQueueSize=%d!\n", 
                        i, audioQueue_[i].size(), maxAudioQueueSize, minAudioQueueSize);

                    u32 totalIter = ceil(((double)audioQueue_[i].size())/2);
                    audioTsMapper_[i].discardFrames(totalIter);

                    //A simple algorithm to drop the latest half of the frames
                    for(u32 j=0; j < totalIter; j++ ) {
                        audioQueue_[i].pop_back();
                    }

                    /*
                    //The following algorithm is to quickly playback video as fast as possible.
                    //algorithm to speed up the playback by merging 2 samples into 1.
                    //In practise, the audio effect is not ideal.
                    list<SmartPtr<AudioRawData> > tempQueue;
                    for(u32 j = 0; j < totalIter; j++ ) {
                        SmartPtr<AudioRawData> a1 = audioQueue_[i].front();
                        audioQueue_[i].pop_front();
                        SmartPtr<AudioRawData> a2 = audioQueue_[i].front();
                        audioQueue_[i].pop_front();
                        //combine a1 and a2 and push into the end of the temp queue queue
                        SmartPtr<AudioRawData> c = AudioMixer::combineAudioRawData( a1, a2 );
                        tempQueue.push_back(c) ;
                    }
                    while( tempQueue.size() > 0 ) {
                        SmartPtr<AudioRawData> c = tempQueue.back();
                        audioQueue_[i].push_front( c );
                        tempQueue.pop_back();
                    }
                    */
                    //printQueueInfo(i);
                    //then calculate maxAudioQueueSize again
                    calcQueueSize(maxAudioQueueSize, minAudioQueueSize);
                    LOG("---------->After audio stream %d trimmed, audioQueue_[i].size()=%d, maxAudioQueueSize=%d, minAudioQueueSize=%d!\n", 
                        i, audioQueue_[i].size(), maxAudioQueueSize, minAudioQueueSize);
                }
            }
        }    
    }

    //all audio frame rate is the same
    for(u32 i = 0; i < MAX_XCODING_INSTANCES; i++ ) {
        if ( audioStreamStatus_[i] == kStreamOnlineStarted ) { 
            if( audioQueue_[i].size() > 0) {
                nextAudioTimestamp_[i] = audioQueue_[i].front()->pts;
                maxAudioTimestamp = MAX( audioQueue_[i].front()->pts, maxAudioTimestamp );
            } else {
                bool bCannotPopout = true;
                if (  maxAudioQueueSize >= MIN_LATE_AUDIO_FRAME_THRESHOLD ) {  
                    //move forward only if enough time has elapsed since last popout, otherwise, give it a pause
                    bool enoughTimeElapsed = true;
                    u64 elpasedTimeInMs = (getEpocTime() - lastAudioPopoutTime_ );
                    if( lastAudioPopoutTime_ && elpasedTimeInMs < MP3_FRAME_MAX_GAP_IN_MS) {
                        enoughTimeElapsed = false;
                    }
                    //Needs to push more than 1 frames b/c gap coudl be too wide.
                    if( enoughTimeElapsed ) {
                        int numOfFramesInserted = ceil(((double)elpasedTimeInMs)/MP3_FRAME_INTERVAL_IN_MS);
                        for( int j = 0; j < numOfFramesInserted; j++ ) {
                            //case 1, a frame arrives too late and will come in batch mode afterwards
                            //case 2, a timestamp jump, meaning there are missing frames.
                            SmartPtr<AudioRawData> a = new AudioRawData();
                            bool bIsStereo = false;
                            u32 origPts = audioTsMapper_[i].getLastOrigTimestamp() + 1; //does NOT matter
                            //Don't duplicate the previous frame, but use a blank frame instead
                            //a->rawAudioFrame_ = audioDecoder_[i]->getPrevRawMp3Frame(bIsStereo);
                            SmartPtr<SmartBuffer> prevFrame = audioDecoder_[i]->getPrevRawMp3Frame(bIsStereo);
                            a->rawAudioFrame_ = SmartBuffer::genBlankBuffer( prevFrame );
                            a->bIsStereo = bIsStereo;
                            a->pts = audioTsMapper_[i].getNextTimestamp( origPts );
                            audioQueue_[i].push_back( a );
                            
                            LOG("---------->Stream:%d push an empty audio frame, max queue size=%d exceeded, pts=%d, isStereo=%d, elapsedTime=%dms\r\n", i, maxAudioQueueSize, a->pts, a->bIsStereo, elpasedTimeInMs);
                            if( !j ) {
                                nextAudioTimestamp_[i] = audioQueue_[i].front()->pts;
                                maxAudioTimestamp = MAX( audioQueue_[i].front()->pts, maxAudioTimestamp );
                            }
                        }
                        //printQueueSize();
                        bCannotPopout = false;
                    } else {
                        //LOG("-------->Stream:%d queue emtpy. Max queue size=%d exceeded, elapsedTime=%dms < %dms\r\n", i, maxAudioQueueSize, elpasedTimeInMs, MP3_FRAME_MAX_GAP_IN_MS);
                    }
                }

                if( bCannotPopout ) {
                    nextAudioTimestamp_[i] = 0; //reset the timestamp to indicate it's missing
                    isReady = false;
                    break;
                    //LOG( "---streamMask online unavailable index=%d, numStreams=%d\r\n", i, numStreams_);
                }

                break;
            }   
            totalStreams++;
        }
    }
    return totalStreams?isReady:false;
}

bool FLVSegmentInput::isStreamOnlineStarted(StreamType streamType, int index)
{
    if( streamType == kVideoStreamType ) {
        return ( videoStreamStatus_[index] == kStreamOnlineStarted );
    } else if( streamType == kAudioStreamType ) {
        return ( audioStreamStatus_[index] == kStreamOnlineStarted );
    } else {
        return false;
    }
}

void FLVSegmentInput::onFLVFrameParsed( SmartPtr<AccessUnit> au, int index )
{
    if( au->st == kVideoStreamType ) {
        if( !videoDecoder_[index] )  {
            videoDecoder_[index] = new VideoDecoder(index, au->ctype);
        }
        SmartPtr<VideoRawData> v = new VideoRawData();
        bool bIsValidFrame = videoDecoder_[index]->newAccessUnit(au, v); //decode here
        if( bIsValidFrame ) { //if decoded successfully(it can be an sps pps frame)
            if( MAX_VIDEO_QUEUE_SIZE <= videoQueue_[index].size())  {
                LOG("------Cannot enqueue video frame, clear it. index=%d, queuesize=%d, pts=%d, videoInQueuePts=%d, nextVideoTimestamp=%d,  lastBucketTimestamp_=%.2f\r\n", index, videoQueue_[index].size(), v->pts, videoQueue_[index].front()->pts, nextVideoTimestamp_[index],  lastBucketTimestamp_[index]);
                videoQueue_[index].clear();
            } 
            //LOG("------Enqueue video frame, index=%d, queuesize=%d, pts=%d\r\n", index, videoQueue_[index].size(), v->pts);
            videoQueue_[index].push_back( v );
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
            audioQueue_[index].push_back( a );
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

bool FLVSegmentInput::isNextVideoFrameSpsPps(u32 index, u32& timestamp)
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
SmartPtr<VideoRawData> FLVSegmentInput::getNextVideoFrame(u32 index)
{
    SmartPtr<VideoRawData> v;
    if ( videoQueue_[index].size() > 0 ) {
        u32 timestamp = nextVideoTimestamp_[index];
        v = videoQueue_[index].front();
        if ( v && v->pts <= timestamp ) {
            videoQueue_[index].pop_front();
            if( videoQueue_[index].size() > 0 ) {
                LOG("------pop next video frame, index=%d cur_pts=%d last_pts=%d queue=%d\r\n", index, v->pts, videoQueue_[index].back()->pts, videoQueue_[index].size()+1);
            } else {
                LOG("------pop next video frame, index=%d cur_pts=%d last_pts=%d queue=%d\r\n", index, v->pts, 0, videoQueue_[index].size()+1);
            }
        } else {
            //LOG("------nopop Next video frame, index=%d queue=%d\r\n", index, videoQueue_[index].size());
            //don't pop anything that has a bigger timestamp
            v = NULL;
        }
    }
    return v;
}

SmartPtr<AudioRawData> FLVSegmentInput::getNextAudioFrame(u32 index)
{
    SmartPtr<AudioRawData> a;
    if ( audioQueue_[index].size() > 0 ) {
        a = audioQueue_[index].front();
        if ( a ) {
            audioQueue_[index].pop_front();
            
            if( audioQueue_[index].size() > 0 ) {
                LOG("------pop next audio frame, index=%d cur_pts=%d last_pts=%d queue=%d\r\n", index, a->pts, audioQueue_[index].back()->pts, audioQueue_[index].size()+1);
            } else {
                LOG("------pop next audio frame, index=%d cur_pts=%d last_pts=%d queue=%d\r\n", index, a->pts, 0, audioQueue_[index].size()+1);
            }
            lastAudioPopoutTime_ = getEpocTime();
        }
    }
    return a;
}

//callbacks from FLVSegmentParser
void FLVSegmentInput::onStreamOffline(int index)
{
    delete( audioDecoder_[index] );
    audioDecoder_[index] = NULL; //initialize it later
    delete( videoDecoder_[index] );
    videoDecoder_[index] = NULL; //initialize it later
    audioTsMapper_[index].reset();
    nextAudioTimestamp_[index] = 0;
    nextVideoTimestamp_[index] = 0;
    momentoBucketTimestamp_[index] = MAX_U32;
    lastBucketTimestamp_[index] = 0;
    hasStarted_[index] = 0;
    delegate_->onStreamEnded(index);
}

void FLVSegmentInput::restoreVideoMomentoTimestamp(int i)
{
    if( momentoBucketTimestamp_[i] != MAX_U32 ) {
        lastBucketTimestamp_[i] = momentoBucketTimestamp_[i];
        momentoBucketTimestamp_[i] = MAX_U32;
    }
}
