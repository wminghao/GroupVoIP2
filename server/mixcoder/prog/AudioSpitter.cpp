#include "AudioSpitter.h"
#include "fwk/log.h"


//exact spit is 8 frames, do 1 extra spit
const u32 GCD_MP3 = 8;
const u32 GCD_AAC = 9;


//return true means there is an extra output.
bool AudioSpitter::swallow( SmartPtr<SmartBuffer> input, u32 inputTs)
{
    ASSERT( outputSamplesPerFrame_ < inputSamplesPerFrame_ );
    bool isExtraReady = false;

    u32 outputFrameSize = outputSamplesPerFrame_*numChannels_*sizeof(u16);
    SmartPtr<SmartBuffer> temp = new SmartBuffer( outputFrameSize );
    
    if( numSamplesRemaining_ ) {
        ASSERT( audioFrameList_.size() == 1 );
        SmartPtr<SmartBuffer> frontBuf = audioFrameList_.front();
        memcpy( frontBuf->data() + numSamplesRemaining_*numChannels_*sizeof(u16), input->data(), ( outputSamplesPerFrame_ - numSamplesRemaining_ ) * numChannels_*sizeof(u16) );
        u32 numSamplesLeft = inputSamplesPerFrame_ - (outputSamplesPerFrame_ - numSamplesRemaining_);
        memcpy( temp->data(), input->data() + ( outputSamplesPerFrame_ - numSamplesRemaining_ ) * numChannels_*sizeof(u16), numSamplesLeft  * numChannels_*sizeof(u16));
        audioFrameList_.push_back( temp );

        //LOG( "===audioSpitter, swallow a partial frame, numSamplesRemaining_=%d, numSamplesLeft=%d ", numSamplesRemaining_, numSamplesLeft );
        numSamplesRemaining_ = numSamplesLeft;
    } else {
        nextTimestamp_ = inputTs;
        memcpy( temp->data(), input->data(), outputFrameSize );
        audioFrameList_.push_back( temp );
        temp = new SmartBuffer( outputFrameSize );
        numSamplesRemaining_ = inputSamplesPerFrame_ - outputSamplesPerFrame_;
        memcpy( temp->data(), input->data() + outputFrameSize, numSamplesRemaining_ * numChannels_*sizeof(u16));
        //LOG( "===audioSpitter, swallow a full frame, numSamplesRemaining_=%d.", numSamplesRemaining_ );
        audioFrameList_.push_back( temp );
    }

    totalInputFramesCount_++;

    //if it's an exact match, spit out
    if( numSamplesRemaining_ == outputSamplesPerFrame_ ) {
        ASSERT( totalInputFramesCount_ == GCD_MP3 );
        isExtraReady = true;
        numSamplesRemaining_ = 0;
        totalInputFramesCount_ = 0;
    }

    return isExtraReady;
}

SmartPtr<SmartBuffer> AudioSpitter::spit(u32& outputTs)
{
    SmartPtr<SmartBuffer> res = audioFrameList_.front();
    audioFrameList_.pop_front();
    outputTs = nextTimestamp_ + AAC_FRAME_INTERVAL_IN_MS * totalOutputFramesCount_;
    totalOutputFramesCount_++;
    if( totalOutputFramesCount_ == GCD_AAC ) {
        totalOutputFramesCount_ = 0;
    }
    //LOG( "===audioSpitter, spit a full frame, numSamplesRemaining_=%d, outputPts=%d.", numSamplesRemaining_, outputTs );
    return res;
}
