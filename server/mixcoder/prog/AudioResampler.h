#ifndef __AUDIO_RESAMPLER__
#define __AUDIO_RESAMPLER__

#include "fwk/Units.h"
extern "C" {
#include <samplerate.h> //resampling
}
#include <list>
#include <stdlib.h>
#include "fwk/SmartBuffer.h"
#include "fwk/log.h"
#include "fwk/Units.h"
#include "CodecInfo.h"

//an audio resampler from ffmpeg
class AudioResampler
{
 public:
 AudioResampler(int inputFreq, int inputChannels, int outputFreq, int outputChannels, AudioCodecId outputCodecId):
    inputFreq_(inputFreq), inputChannels_(inputChannels), outputFreq_(outputFreq), outputChannels_(outputChannels), remainingSampleCnt_(0){
        /* resample */
        alloc();
        if( outputCodecId == kAAC) {
            samplesPerFrame_ = AAC_FRAME_SAMPLE_SIZE;
        } else {
            //assume it's mp3
            samplesPerFrame_ = MP3_FRAME_SAMPLE_SIZE;
        } 

        frameSize_ = samplesPerFrame_ * sizeof(short) * outputChannels_;
        ASSERT(inputChannels_==1 || inputChannels_==2);
        ASSERT(outputChannels_==2);
    }
    ~AudioResampler(){
        reset();
        while( audioFrameList_.size() > 0 ) {
            audioFrameList_.pop_back();
        }
    }
    
    //return success or failure
    bool resample(u8* inputData, u32 sampleSize);

    //get the next batch of frames
    bool isNextRawFrameReady();
    //return a smartbuffer
    SmartPtr<SmartBuffer> getNextRawFrame(bool& bIsStereo);
    SmartPtr<SmartBuffer> getPrevRawFrame(bool& bIsStereo);

    static u32 getSamplesPerFrame(AudioCodecId outputCodecId) { return ( outputCodecId == kAAC)? AAC_FRAME_SAMPLE_SIZE:MP3_FRAME_SAMPLE_SIZE; }

    //bool isStereo() { return (inputChannels_ == 2); }

    //when a timestamp jump happens, discard the previous resampler residual
    //void discardResidual();

 private:
    void alloc() {
        int error = 0;
        resamplerState_ = src_new( SRC_SINC_MEDIUM_QUALITY, inputChannels_, &error );
        if( !resamplerState_ ) {
            LOG("***Cannot create resampler! inputChannels_=%d\n", inputChannels_);
        }
        ASSERT(resamplerState_);
    }
    void reset() {
        if( resamplerState_) {            
            src_delete( resamplerState_ );
            resamplerState_ = 0;
        }
        remainingSampleCnt_ = 0;
    }

 private:
    /* Resample */
    SRC_STATE* resamplerState_;
    
    /* temp buffers, one second at 44 khz times two channels - its PLENTY */
    float resampleFloatBufIn_[44100 * 2];
    float resampleFloatBufOut_[44100 * 2];
    short resampleShortBufOut_[44100 * 2];

    //channel info
    int inputFreq_;
    int inputChannels_;
    int outputFreq_;
    int outputChannels_;

    //linked list of mp3 raw frame of 1152 samples or aac of 1024 samples
    std::list<SmartPtr<SmartBuffer> > audioFrameList_; // integer list
    short resampleShortRemaining_[44100 * 2]; //save reamining data from the previous read, stereo
    u32 remainingSampleCnt_;

    //frame size
    u32 frameSize_;

    //prev buffer 
    SmartPtr<SmartBuffer> prevBuf_;

    //samples per frame
    u32 samplesPerFrame_;
};
#endif //
