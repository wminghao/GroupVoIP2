//
//  MixCoder.cpp
//  
//
//  Created by Howard Wang on 2/28/14.
//
//
#include "MixCoder.h"
#include "FLVSegmentInput.h"
#include "FLVSegmentOutput.h"
#include "AudioSpeexEncoder.h"
#include "AudioMp3Encoder.h"
//#include "AudioFaacEncoder.h"
#include "AudioFdkaacEncoder.h"
#include "VideoFfmpegEncoder.h"
#include "VideoVp8Encoder.h"
#include "VideoH264Encoder.h"
#include "AudioSpitter.h"
#include "AudioMixer.h"
#include "VideoMixer.h"
#include "fwk/log.h"
#include "fwk/Units.h"

MixCoder::MixCoder(VideoCodecId vCodecId, int vBitrate, int width, int height, 
                   AudioCodecId aCodecId, int aBitrate, int frequency) : 
    vBitrate_(vBitrate),
    vWidth_(width),
    vHeight_(height),
    aBitrate_(aBitrate),
    aFrequency_(frequency),
    transitionState_(NO_TRANSITION_STATE),
    totalStreamsCached_(0)
{
    VideoStreamSetting vOutputSetting = { vCodecId, vWidth_, vHeight_ }; 
    AudioStreamSetting aOutputSetting = { aCodecId, getAudioRate(44100), kSndStereo, kSnd16Bit, 0, (StreamSource)0, 0 };

    //flv input
    flvSegInput_ = new FLVSegmentInput( this, 30, &aOutputSetting ); //end result 30 fps

    //flv output
    flvSegOutput_ = new FLVSegmentOutput( &vOutputSetting, &aOutputSetting );
                                         
    switch( vCodecId ) {
       case kH263VideoPacket: 
       case kVP6VideoPacket: {
           videoEncoder_ = new VideoFfmpegEncoder( &vOutputSetting, vBitrate_, vCodecId );
           break;
       }
       case kVP8VideoPacket: {
           videoEncoder_ = new VideoVp8Encoder( &vOutputSetting, vBitrate_ );
           break;
       }
       case kAVCVideoPacket: 
       default: {
           videoEncoder_ = new VideoH264Encoder( &vOutputSetting, vBitrate_ );
           break;
       }
    }


    videoMixer_ = new VideoMixer(&vOutputSetting);
    audioMixer_ = new AudioMixer();

    for( u32 i = 0; i < MAX_XCODING_INSTANCES; i++ ) {
        switch( aCodecId ) {
            case kSpeex:{
                audioEncoder_[i] = new AudioSpeexEncoder( &aOutputSetting, aBitrate_ );
                break;
            } 
            case kMP3:{
                audioEncoder_[i] = new AudioMp3Encoder( &aOutputSetting, aBitrate_ );
                break;
            }
            case kAAC:
            default:{
                //Don't use faac since it introduces longer delay
                //audioEncoder_[i] = new AudioFaacEncoder( &aOutputSetting, aBitrate_ );
                //use fdkaac low latency mode
                audioEncoder_[i] = new AudioFdkaacEncoder( &aOutputSetting, aBitrate_ );
                break;
            }
        }
    }
#ifdef FORCE_AAC_ALL_IN_ONE
    ASSERT(aCodecId == kMP3);
    //
    //the all-in-one audio encoder must be AAC instead of mp3, 
    //since many video players cannot playback offline hardware decoded H264+Mp3 video.
    //for example, air for android cannot play h264+mp3 not in real-time mode. Meaning they use hw decoding.
    //
    aOutputSetting.acid = kAAC;
    //audio spitter does the conversion
    audioSpitter_ = new AudioSpitter( flvSegInput_->getSamplesPerFrame(), getNumChannels(aOutputSetting.at) );
    audioEncoder_[MAX_XCODING_INSTANCES] = new AudioFdkaacEncoder( &aOutputSetting, aBitrate_ );
#else 
    switch( aCodecId ) {
    case kSpeex:{
        audioEncoder_[MAX_XCODING_INSTANCES] = new AudioSpeexEncoder( &aOutputSetting, aBitrate_ );
        break;
    }
    case kMP3:{
        audioEncoder_[MAX_XCODING_INSTANCES] = new AudioMp3Encoder( &aOutputSetting, aBitrate_ );
        break;
    }
    case kAAC:
    default:{
        //Don't use faac since it introduces longer delay
        //audioEncoder_[i] = new AudioFaacEncoder( &aOutputSetting, aBitrate_ );
        //use fdkaac low latency mode
        audioEncoder_[MAX_XCODING_INSTANCES] = new AudioFdkaacEncoder( &aOutputSetting, aBitrate_ );
    }
    }
#endif //FORCE_AAC_ALL_IN_ONE
}

MixCoder::~MixCoder() {
    delete flvSegInput_;
    delete flvSegOutput_;
    for( u32 i = 0; i < MAX_XCODING_INSTANCES+1; i ++ ) {
        delete audioEncoder_[i];
    }
    delete videoEncoder_;
    delete videoMixer_;
    delete audioMixer_;
}

/* returns false if we hit some bad data, true if OK */
bool MixCoder::newInput( SmartPtr<SmartBuffer> inputBuf )
{
    return (flvSegInput_->readData( inputBuf ) > 0);
}

//read output from the system
SmartPtr<SmartBuffer> MixCoder::getOutput()
{
    StreamType curStreamType = kUnknownStreamType;
    u32 audioPts = 0; //max audio Pts as the final pts
    bool bIsAudioReady = flvSegInput_->isNextAudioStreamReady( audioPts );

    u32 videoPts = 0;//max video Pts as the final pts
    bool bIsVideoReady = false;
    if(bIsAudioReady || flvSegInput_->isNoStreamsAudioStarted()) {
        bIsVideoReady = flvSegInput_->isNextVideoStreamReady( videoPts );
    }

    if( bIsVideoReady && bIsAudioReady) {
        //audio and video are both ready.
        if ( audioPts < videoPts ) {
            curStreamType = kAudioStreamType;
        } else {
            curStreamType = kVideoStreamType;
        }
    } else if ( bIsAudioReady ) {
        //audio ready, video not ready, continue
        curStreamType = kAudioStreamType;
    } else if( bIsVideoReady ) {
        //for video ready, audio not ready case, do not pursue, since audio is always continuous.
        curStreamType = kVideoStreamType;
    }

    SmartPtr<SmartBuffer> resultFlvPacket = NULL;
    if ( curStreamType != kUnknownStreamType ) {
        //LOG("------curStreamType=%d, audioPts=%d, videoPts=%d, bIsVideoReady=%d, bIsAudioReady=%d\n", curStreamType, audioPts, videoPts, bIsVideoReady, bIsAudioReady );
        int totalStreams = 0;
        int totalMobileStreams = 0;
        if ( curStreamType == kVideoStreamType ) {
            for( u32 i = 0; i < MAX_XCODING_INSTANCES; i ++ ) {
                flvSegInput_->restoreVideoMomentoTimestamp(i); //update the lastBucketTimestamp
                bool bIsStreamStarted = flvSegInput_->isStreamOnlineStarted(curStreamType, i );
                bool bIsValidFrame = false;
                if( bIsStreamStarted ) { 
                    SmartPtr<VideoRawData> v;
                    do {
                        v = flvSegInput_->getNextVideoFrame(i);
                        if( v ) {
                            rawVideoData_[i] = v;
                            audioOnly_[i] = false;
                        }
                    } while (v); //pop a few frames with timestamp smaller than nextVideoTimestamp_[i]

                    //if no frame generated, and never has any frames generated before, do nothing, 
                    //else use the cached video frame 
                    if( flvSegInput_->hasFirstFrameDecoded(i, true)) {
                        bIsValidFrame = true; //use the cached frame
                    }
                }
                if( rawVideoData_[i] ) {
                    rawVideoData_[i]->rawVideoSettings_.ss= flvSegInput_->getStreamSource(i);
                    rawVideoData_[i]->rawVideoSettings_.bIsValid = bIsStreamStarted && bIsValidFrame;
                    if( rawVideoData_[i]->rawVideoSettings_.bIsValid ) {
                        //LOG("------rawVideoData_[%d] is valid\r\n", i);
                        totalStreams++;
                        if( kMobileStreamSource == rawVideoData_[i]->rawVideoSettings_.ss ) {
                            totalMobileStreams++;
                        }
                    }
                } 
            }

            if ( totalStreams > 0 ) {
                bool bIsKeyFrame = false;
                VideoRect videoRect[MAX_XCODING_INSTANCES];
                
                SmartPtr<SmartBuffer> encodedFrame;

                //to avoid a case where video transition happens faster than metadata generation.
                //if there is a transistion, freeze the frame until the next key frame
                if( totalStreams != totalStreamsCached_ ) {
                    if( videoEncoder_->isNextEncodedFrameKeyFrame() ) {
                        transitionState_ = NO_TRANSITION_STATE;
                        totalStreamsCached_ = totalStreams;                    
                        //LOG("------Transition complete. totalVideoStreams = %d, totalStreamsCached=%d\n", totalStreams, totalStreamsCached_ );
                    } else {
                        transitionState_ = IN_TRANSITION_STATE;                        
                    }
                } else {
                    transitionState_ = NO_TRANSITION_STATE;
                }
                if( NO_TRANSITION_STATE == transitionState_ ) {
                    SmartPtr<SmartBuffer> rawFrameMixed = videoMixer_->mixStreams(rawVideoData_, totalStreams, videoRect);
                    rawMixedVideoDataCache_ = rawFrameMixed; //cache the frame
                    memcpy( videoRectCache_, videoRect, sizeof( VideoRect ) * MAX_XCODING_INSTANCES); 
                    encodedFrame = videoEncoder_->encodeAFrame(rawFrameMixed, &bIsKeyFrame);
                } else {
                    //LOG("------Now in transition. totalVideoStreams = %d, totalStreamsCached=%d\n", totalStreams, totalStreamsCached_ );
                    memcpy( videoRect, videoRectCache_, sizeof( VideoRect ) * MAX_XCODING_INSTANCES); 
                    encodedFrame = videoEncoder_->encodeAFrame(rawMixedVideoDataCache_, &bIsKeyFrame);//use the cached frame
                }
                if ( encodedFrame ) {
                    //if there is a video header, save the header first
                    SmartPtr<SmartBuffer> videoHeader = videoEncoder_->genVideoHeader();
                    if( videoHeader ) {
                        flvSegOutput_->saveVideoHeader( videoHeader );
                    }

                    //for the all-in stream
                    flvSegOutput_->packageVideoFrame(encodedFrame, videoPts, bIsKeyFrame, MAX_XCODING_INSTANCES);

                    //for each individual mobile stream, always mix
                    //for non-mobile stream, there is nothing to mix, except for all-audio stream where others video needs to be displayed
                    for( u32 i = 0; i < MAX_XCODING_INSTANCES; i ++ ) {
                        if( rawVideoData_[i] &&  rawVideoData_[i]->rawVideoSettings_.bIsValid && kMobileStreamSource == rawVideoData_[i]->rawVideoSettings_.ss) {
                            if( bIsKeyFrame ) {
                                //LOG("------Transition Complete Cuepoint. totalVideoStreams = %d, totalStreamsCached=%d\n", totalStreams, totalStreamsCached_ );
                                //every key frame insert a cuepoint
                                flvSegOutput_->packageCuePoint(i, &videoRect[i], videoPts);
                            }
                            //LOG("------totalVideoStreams = %d, totalMobileStreams=%d\n", totalStreams, totalMobileStreams );
                            flvSegOutput_->packageVideoFrame(encodedFrame, videoPts, bIsKeyFrame, i);
                        } else if( audioOnly_[i] ) {
                            flvSegOutput_->packageVideoFrame(encodedFrame, videoPts, bIsKeyFrame, i);
                        }
                    }
                    resultFlvPacket = flvSegOutput_->getOneFrameForAllStreams(true);
                }
            } 
        } else {
            for( u32 i = 0; i < MAX_XCODING_INSTANCES; i ++ ) {
                bool bIsStreamStarted = flvSegInput_->isStreamOnlineStarted(curStreamType, i );
                bool bIsValidFrame = false;
                if( bIsStreamStarted ) {
                    SmartPtr<AudioRawData> a = flvSegInput_->getNextAudioFrame(i);
                    if ( a ) {
                        rawAudioData_[i] = a;
                        bIsValidFrame = true;
                    } else {
                        //if no frame generated, and never has any frames generated before, do nothing, 
                        //else use the cached audio frame 
                        if( flvSegInput_->hasFirstFrameDecoded(i, false)) {
                            bIsValidFrame = true; //use the cached frame
                        } 
                    }
                }
                if( rawAudioData_[i] ) {
                    rawAudioData_[i]->ss = flvSegInput_->getStreamSource(i);
                    rawAudioData_[i]->bIsValid = bIsStreamStarted && bIsValidFrame;
                    if( rawAudioData_[i]->bIsValid ) {
                        totalStreams++;
                        if( kMobileStreamSource == rawAudioData_[i]->ss ) {
                            totalMobileStreams++;
                        }
                    }
                }
            }

            if ( totalStreams > 0 ) {

                //LOG("------totalAudioStreams = %d, totalMobileStreams=%d\n", totalStreams, totalMobileStreams );

                //for all in stream
                SmartPtr<SmartBuffer> rawFrameMixed = audioMixer_->mixStreams(rawAudioData_, flvSegInput_->getSamplesPerFrame(), totalStreams, MAX_U32);

#ifdef FORCE_AAC_ALL_IN_ONE
                bool extra = audioSpitter_->swallow( rawFrameMixed, audioPts );
                u32 outputPts = 0;
                SmartPtr<SmartBuffer> rawOutput = audioSpitter_->spit(outputPts);
                SmartPtr<SmartBuffer> encodedFrame = audioEncoder_[MAX_XCODING_INSTANCES]->encodeAFrame(rawOutput);
                if ( encodedFrame ) {
                    SmartPtr<SmartBuffer> audioHeader = audioEncoder_[MAX_XCODING_INSTANCES]->genAudioHeader();
                    if( audioHeader ) {
                        flvSegOutput_->saveAudioHeader( audioHeader, MAX_XCODING_INSTANCES );
                    }
                    flvSegOutput_->packageAudioFrame(encodedFrame, outputPts, MAX_XCODING_INSTANCES);
                }
                //for the extra packet.
                if( extra ) {
                    rawOutput = audioSpitter_->spit(outputPts);
                    encodedFrame = audioEncoder_[MAX_XCODING_INSTANCES]->encodeAFrame(rawOutput);
                    flvSegOutput_->packageAudioFrame(encodedFrame, outputPts, MAX_XCODING_INSTANCES);
                } 
#else //FORCE_AAC_ALL_IN_ONE
                SmartPtr<SmartBuffer> encodedFrame = audioEncoder_[MAX_XCODING_INSTANCES]->encodeAFrame( rawFrameMixed );
                if ( encodedFrame ) {
                    SmartPtr<SmartBuffer> audioHeader = audioEncoder_[MAX_XCODING_INSTANCES]->genAudioHeader();
                    if( audioHeader ) {
                        flvSegOutput_->saveAudioHeader( audioHeader, MAX_XCODING_INSTANCES );
                    }
                    flvSegOutput_->packageAudioFrame(encodedFrame, audioPts, MAX_XCODING_INSTANCES);
                }
#endif //FORCE_AAC_ALL_IN_ONE

                //for each individual mobile stream
                if ( totalMobileStreams ) { 
                    //for non-mobile stream, there is nothing to mix
                    for( u32 i = 0; i < MAX_XCODING_INSTANCES; i ++ ) {
                        if( rawAudioData_[i] && rawAudioData_[i]->bIsValid && kMobileStreamSource == rawAudioData_[i]->ss) {
                            //LOG("----------------------------totalAudioStreams = %d, mobileStream index=%d\n", totalStreams, i );
                            SmartPtr<SmartBuffer> rawFrameMixed = audioMixer_->mixStreams(rawAudioData_, flvSegInput_->getSamplesPerFrame(), totalStreams, i);
                            SmartPtr<SmartBuffer> encodedFrame = audioEncoder_[i]->encodeAFrame(rawFrameMixed);
                            if ( encodedFrame ) {
                                SmartPtr<SmartBuffer> audioHeader = audioEncoder_[i]->genAudioHeader();
                                if( audioHeader ) {
                                    flvSegOutput_->saveAudioHeader( audioHeader, i );
                                }
                                flvSegOutput_->packageAudioFrame(encodedFrame, audioPts, i);
                            }
                        }
                    }
                }

                resultFlvPacket = flvSegOutput_->getOneFrameForAllStreams(false);
            }
        }
    }
    return resultFlvPacket;
}

void MixCoder::onStreamEnded(int streamId)
{
    flvSegOutput_->onStreamEnded(streamId);
}

void MixCoder::onVideoFrameClear(int index) {
    LOG("--------onVideoFrameClear for index=%d-----", index);
    rawVideoData_[index] = NULL;    
    audioOnly_[index] = true;
}

//at the end. flush the input
void MixCoder::flush()
{
    //TODO, flush the rest of the stream, not implemented
}
