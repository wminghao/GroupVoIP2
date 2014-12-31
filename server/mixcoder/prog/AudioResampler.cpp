#include "AudioResampler.h"
#include "fwk/log.h"
#include <stdio.h>
#include <string.h>

//return the many samples
bool AudioResampler::resample(u8* inputData, u32 sampleSize)
{
    u32 totalInputBytes =  sampleSize * sizeof(short) * inputChannels_;
    u32 sampleCount = 0;
    if ( inputFreq_ == outputFreq_ ) {
        //direct copy w/o resampling
        memcpy(resampleShortBufOut_, inputData, totalInputBytes);
        sampleCount = sampleSize;
        //LOG("======no need for resampling, copy over sampleSize=%d\r\n", sampleSize);
    } else {
        //convert to float
        src_short_to_float_array( (const short* )inputData,
                                  resampleFloatBufIn_,
                                  totalInputBytes/sizeof(short) );
        SRC_DATA srcData;
        srcData.data_in = resampleFloatBufIn_;
        srcData.data_out = resampleFloatBufOut_;
        srcData.input_frames = sampleSize;
        srcData.output_frames = 44100; /* 44100 big enough */
        srcData.src_ratio = ((double)outputFreq_)/((double)inputFreq_);
        srcData.end_of_input = 0;
        
        if( 0 != src_process( resamplerState_, &srcData ) ) {
            LOG( "src_proces FAILED\n");
            return false;
        }
        sampleCount = srcData.output_frames_gen;

        //convert back to short
        src_float_to_short_array( (const float*) resampleFloatBufOut_,
                                  resampleShortBufOut_,
                                  sampleCount * inputChannels_ );
    }
    LOG("=============Start iteration!!!");
    //push the samples into an linked list
    u32 samplesToSkip = 0;

    while( sampleCount > 0 ) {
        u32 samplesToCopyFromOutBuf = 0;

        if( remainingSampleCnt_ ) {
            u32 remainingBytes = remainingSampleCnt_ * sizeof(short) * inputChannels_;
            //copy the remaining sample count first
            if( remainingSampleCnt_ + sampleCount >= samplesPerFrame_ ) {
                SmartPtr<SmartBuffer> rawFrame = new SmartBuffer( samplesPerFrame_ * sizeof(short) * inputChannels_ );
                u8* rawFrameData = rawFrame->data();
                memcpy(rawFrameData, (u8*)resampleShortRemaining_, remainingBytes);

                samplesToCopyFromOutBuf = samplesPerFrame_ - remainingSampleCnt_;
                memcpy(rawFrameData + remainingBytes, (u8*)(resampleShortBufOut_ + samplesToSkip * inputChannels_), samplesToCopyFromOutBuf * sizeof(short) * inputChannels_);
                audioFrameList_.push_back( rawFrame );

                samplesToSkip += samplesToCopyFromOutBuf;
                remainingSampleCnt_ = 0;

                LOG("======got a part-part frame, sampleCount=%d, samplesToSkip=%d, remainingSampleCnt_=%d, samplesToCopyFromOutBuf=%d===\r\n", 
                    sampleCount, samplesToSkip, remainingSampleCnt_, samplesToCopyFromOutBuf);
            } else {
                memcpy((u8*)resampleShortRemaining_+remainingBytes, (u8*)(resampleShortBufOut_ + samplesToSkip * inputChannels_), sampleCount * sizeof(short) * inputChannels_);

                remainingSampleCnt_ += sampleCount;
                LOG("======got nothing, sampleCount=%d, samplesToSkip=%d, remainingSampleCnt_=%d, samplesToCopyFromOutBuf=%d===\r\n", 
                    sampleCount, samplesToSkip, remainingSampleCnt_, samplesToCopyFromOutBuf);
                break;
            }
        } else {
            //no residual, so create a new buffer
            if( sampleCount >= samplesPerFrame_ ) {
                u32 bytesToCopy = samplesPerFrame_ * sizeof(short) * inputChannels_;
                SmartPtr<SmartBuffer> rawFrame = new SmartBuffer( bytesToCopy );
                u8* rawFrameData = rawFrame->data();
                memcpy(rawFrameData, (u8*)(resampleShortBufOut_ + samplesToSkip * inputChannels_), bytesToCopy);
                audioFrameList_.push_back( rawFrame );
                
                remainingSampleCnt_ = 0;
                samplesToCopyFromOutBuf = samplesPerFrame_;
                samplesToSkip += samplesToCopyFromOutBuf;

                LOG("======got a brand new frame, sampleCount=%d, samplesToSkip=%d, remainingSampleCnt_=%d, samplesToCopyFromOutBuf=%d===\r\n", 
                    sampleCount, samplesToSkip, remainingSampleCnt_, samplesToCopyFromOutBuf);
            } else {
                memcpy((u8*)resampleShortRemaining_, (u8*)(resampleShortBufOut_+samplesToSkip*inputChannels_), sampleCount * sizeof(short) * inputChannels_);

                remainingSampleCnt_ = sampleCount;
                LOG("======Save residual, not enough for a frame, sampleCount=%d, samplesToSkip=%d, remainingSampleCnt_=%d, samplesToCopyFromOutBuf=%d===\r\n", 
                    sampleCount, samplesToSkip, remainingSampleCnt_, samplesToCopyFromOutBuf);

                break;
            }
        }
        sampleCount -= samplesToCopyFromOutBuf;
    }
    LOG("=============End iteration!!!");
    return true;
}

bool AudioResampler::isNextRawFrameReady()
{
    return (audioFrameList_.size() > 0);
}

//return a buffer, must be freed outside
SmartPtr<SmartBuffer> AudioResampler::getNextRawFrame(bool& bIsStereo)
{
    SmartPtr<SmartBuffer> res;
    if( audioFrameList_.size() > 0 ) {
        bIsStereo = (inputChannels_ == 2);
        res = audioFrameList_.back();
        audioFrameList_.pop_back();
        prevBuf_ = res;
    }
    return res;
}
SmartPtr<SmartBuffer> AudioResampler::getPrevRawFrame(bool& bIsStereo)
{
    bIsStereo = (inputChannels_ == 2);
    return prevBuf_;
}
