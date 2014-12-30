#ifndef __FLVSEGMENTOUTPUT_H__
#define __FLVSEGMENTOUTPUT_H__

#include "fwk/SmartBuffer.h"
#include "CodecInfo.h"

///////////////////////////////////
//SegmentOutput format as follows
// Header:
//  Meta data = 3 bytes //starting with SGO //segment output
//  StreamMask = 4 byte //max of 32 output streams
// Content * (NoOfStreams+1): //0 is the all-mixed stream, 1-NoOfStreams are for each mobile stream
//  streamId = 8 bits
//  LengthOfStream = 4 bytes
//  StreamData = n bytes
///////////////////////////////////

class FLVOutput;
class FLVSegmentOutput
{
 public:
    FLVSegmentOutput(VideoStreamSetting* videoSetting, AudioStreamSetting* audioSetting);
    ~FLVSegmentOutput();

    SmartPtr<SmartBuffer> getOneFrameForAllStreams();

    bool packageVideoFrame(SmartPtr<SmartBuffer> videoPacket, u32 ts, bool bIsKeyFrame, int streamId);
    bool packageAudioFrame(SmartPtr<SmartBuffer> audioPacket, u32 ts, int streamId);
    bool packageCuePoint( int streamId, VideoRect* videoRect, u32 ts );

    void saveVideoHeader( SmartPtr<SmartBuffer> videoHeader );
    void saveAudioHeader( SmartPtr<SmartBuffer> audioHeader, int i );
    void onStreamEnded(int streamId);

 private:
    SmartPtr<SmartBuffer> outputBuffer_[MAX_XCODING_INSTANCES+1];

    FLVOutput* output_[MAX_XCODING_INSTANCES+1];
    //u32 numStreams_;
};

#endif
