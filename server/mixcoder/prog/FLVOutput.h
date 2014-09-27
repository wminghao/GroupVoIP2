#ifndef __FLVOUTPUT_H__
#define __FLVOUTPUT_H__

#include "fwk/SmartBuffer.h"
#include "CodecInfo.h"

class FLVOutput
{
 public:
    //vp8/h264 video + mp3 audio(16kHz)/speex(16khz)
 FLVOutput(VideoStreamSetting* videoSetting, AudioStreamSetting* audioSetting):flvHeaderSent_(false), videoHeaderSent_(false)
        {
            memcpy(&videoSetting_, videoSetting, sizeof(VideoStreamSetting));
            memcpy(&audioSetting_, audioSetting, sizeof(AudioStreamSetting));
        }

    //streamId and totalStream tells the flv format where is the video located inside the video output
    SmartPtr<SmartBuffer> packageVideoFrame(SmartPtr<SmartBuffer> videoPacket, u32 ts, bool bIsKeyFrame);
    SmartPtr<SmartBuffer> packageAudioFrame(SmartPtr<SmartBuffer> audioPacket, u32 ts);
    SmartPtr<SmartBuffer> packageCuePoint( VideoRect* videoRect, u32 ts );

    //save video header
    void saveVideoHeader( SmartPtr<SmartBuffer> videoHeader ) { videoHeader_ = videoHeader; }

    //onStreamEnded
    void onStreamEnded() { flvHeaderSent_ = false; videoHeaderSent_ = false; }
 private:
    SmartPtr<SmartBuffer> newFlvHeader();
    SmartPtr<SmartBuffer> newVideoHeader(u32 ts);

    VideoStreamSetting videoSetting_;
    AudioStreamSetting audioSetting_;

    bool flvHeaderSent_;
    
    bool videoHeaderSent_;

    SmartPtr<SmartBuffer> videoHeader_;
};

#endif
