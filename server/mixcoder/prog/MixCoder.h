//
//  MixCoder.h
//  
//
//  Created by Howard Wang on 2/28/2014.
//
//

#ifndef __MIXCODERCOMMON_H__
#define __MIXCODERCOMMON_H__

#include "fwk/SmartBuffer.h"
#include "CodecInfo.h"
#include "RawData.h"
#include "FLVSegmentInputDelegate.h"

using namespace std;

class FLVSegmentInput;
class FLVSegmentOutput;
class AudioEncoder;
class VideoEncoder;
class AudioDecoder;
class VideoDecoder;
class AudioMixer;
class VideoMixer;

class MixCoder: public FLVSegmentInputDelegate
{
 public:
    MixCoder(VideoCodecId vCodecId, int vBitrate, int width, int height,
             AudioCodecId aCodecId, int aBitrate, int frequency);
    virtual ~MixCoder();
    
    /* returns false if we hit some badness, true if OK */
    bool newInput( SmartPtr<SmartBuffer> );

    //read output from the system
    SmartPtr<SmartBuffer> getOutput();
    
    //at the end. flush the input
    void flush();

    //delegate for flvSegmentInput
    virtual void onStreamEnded(int streamId);

 private:
    //output settings
    int vBitrate_;
    int vWidth_;
    int vHeight_;
    
    int aBitrate_;
    int aFrequency_;

    //input
    FLVSegmentInput* flvSegInput_;
    //output
    FLVSegmentOutput* flvSegOutput_;
    
    //encoders
    AudioEncoder* audioEncoder_[ MAX_XCODING_INSTANCES+1 ];;
    VideoEncoder* videoEncoder_;

    //mixer
    AudioMixer* audioMixer_[ MAX_XCODING_INSTANCES+1 ]; //need max+1 audio mixer since the mobile viewer should not hear his own voice from the mixing
    VideoMixer* videoMixer_;

    //raw video frame in case it does not exist, yuv 3 planes
    SmartPtr<VideoRawData> rawVideoData_[MAX_XCODING_INSTANCES];

    //raw audio frame in case data is late to arrive
    SmartPtr<AudioRawData> rawAudioData_[MAX_XCODING_INSTANCES];
};

#endif
