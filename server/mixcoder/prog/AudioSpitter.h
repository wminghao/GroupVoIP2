#ifndef __AUDIO_SPITTER__
#define __AUDIO_SPITTER__

#include <list>
#include "fwk/Units.h"
#include "fwk/SmartBuffer.h"
#include "CodecInfo.h"

//This class is useful only b/c Flash player cannot play h264+mp3 on android devices, we need to convert archived source into h264+aac.
//AudioSpitter swallows MP3 raw frames of 1152samples/frame and spits out AAC frames of 1024samples/frame
//We also map the timestamp properly for such case, however, 
//  since the timestamp remapping can cause VLC to not like the stream, works fine on Flash.
//  therefore need to turn it off for VLC.
class AudioSpitter
{
public:
AudioSpitter( u32 inputSamplesPerFrame, u32 numChannels ):
    totalInputFramesCount_(0), 
    totalOutputFramesCount_(0), 
    numSamplesRemaining_(0),
    inputSamplesPerFrame_(inputSamplesPerFrame), 
    outputSamplesPerFrame_(AAC_FRAME_SAMPLE_SIZE), 
    numChannels_(numChannels)
    {
       ASSERT(inputSamplesPerFrame == MP3_FRAME_SAMPLE_SIZE);
    }
    
    //return true means there is an extra output for aac encoding.
    bool swallow( SmartPtr<SmartBuffer> input, u32 inputTs );
    SmartPtr<SmartBuffer> spit(u32& outputTs);

private:
    u32 totalInputFramesCount_;
    u32 totalOutputFramesCount_;

    //linked list of mp3 raw frame of 1152 samples or aac of 1024 samples
    std::list<SmartPtr<SmartBuffer> > audioFrameList_; // integer list
    u32 numSamplesRemaining_;

    u32 inputSamplesPerFrame_;
    u32 outputSamplesPerFrame_;
    u32 numChannels_;

    double nextTimestamp_;
};

#endif
