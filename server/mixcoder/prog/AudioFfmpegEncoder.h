#ifndef __AUDIO_FFMPEG_ENCODER__
#define __AUDIO_FFMPEG_ENCODER__

#include "AudioEncoder.h"

struct AVCodec;
struct AVFrame;
struct AVCodecContext;

//Ffmpeg encoder implementation
class AudioFfmpegEncoder:public AudioEncoder
{
 public:
    AudioFfmpegEncoder(AudioStreamSetting* outputSetting, int aBitrate);
    virtual ~AudioFfmpegEncoder();
    virtual SmartPtr<SmartBuffer> encodeAFrame(SmartPtr<SmartBuffer> input) ;
 private:
    AVCodec* encodeCodec_;
    AVCodecContext* encodeContext_;
    AVFrame* encodeFrame_;
    bool bIsOpened_;
};
#endif //__AUDIO_FFMPEG_ENCODER__
