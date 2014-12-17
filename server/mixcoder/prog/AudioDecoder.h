#ifndef __AUDIODECODER_H
#define __AUDIODECODER_H

#include "fwk/Units.h"
#include "CodecInfo.h"
#include "fwk/SmartBuffer.h"
#include <queue>
#include <stdlib.h>
#include "CodecInfo.h"
#include "AccessUnit.h"
#include "AudioResampler.h"

//audio decoder implementation
class AudioDecoder
{
 public:
    AudioDecoder(int streamId, AudioCodecId codecType, AudioRate audioRate, AudioSize audioSize, AudioType audioType, AudioCodecId outputCodecId):resampler_(NULL) {
        setting_.acid = codecType;
        setting_.ar = audioRate;
        setting_.as = audioSize;
        setting_.at = audioType;
        setting_.ap = 0;
        
        hasFirstFrameDecoded_ = false;
        streamId_ = streamId;
        outputCodecId_ = outputCodecId;
    }
    virtual ~AudioDecoder() {
        delete( resampler_ );
    }
    //send it to the decoder, return the target settings for mixing
    virtual void newAccessUnit( SmartPtr<AccessUnit> au, AudioStreamSetting* rawAudioSetting) = 0;

    const AudioStreamSetting* getAudioInputSetting() const { return &setting_; }

    bool hasFirstFrameDecoded(){ return hasFirstFrameDecoded_; }
    
    //get the next batch of frame
    bool isNextRawFrameReady() {
        if( resampler_ ) {
            return resampler_->isNextRawFrameReady();
        }
        return false;
    }

    //return a buffer, must be freed outside
    SmartPtr<SmartBuffer>  getNextRawFrame(bool& bIsStereo) {
        SmartPtr<SmartBuffer> result;
        if( resampler_ ) {
            result = resampler_->getNextRawFrame(bIsStereo);
        }
        return result;
    }
    //return previous raw frame
    SmartPtr<SmartBuffer> getPrevRawFrame(bool& bIsStereo) {
        SmartPtr<SmartBuffer> result;
        if( resampler_ ) {
            result = resampler_->getPrevRawFrame(bIsStereo);
        }
        return result;
    }
    //indicate if it's stereo or not
    /*
    bool isStereo() {
        bool isStereo = false;
        if( resampler_ ) {
            isStereo = resampler_->isStereo();
        }
        return isStereo;
    }
    */
    /*
    void discardResamplerResidual() {
        if( resampler_ ) {
            resampler_->discardResidual();
        }
    }
    */

 protected:    
    //send it to resampler
    void resampleFrame(AudioStreamSetting* aRawSetting, int sampleSize, u8* outputFrame) {
        if( !resampler_ ) {
            resampler_ = new AudioResampler( getFreq(setting_.ar), getNumChannels(setting_.at), getFreq(aRawSetting->ar), getNumChannels(aRawSetting->at), outputCodecId_);
        }
        if( resampler_ ) {
            resampler_->resample(outputFrame, sampleSize);
        }    
    }
 protected:
    //input audio setting
    AudioStreamSetting setting_;

    bool hasFirstFrameDecoded_;

    int streamId_;
    int sampleSize_;

    AudioResampler* resampler_;    

    AudioCodecId outputCodecId_;
};
#endif
