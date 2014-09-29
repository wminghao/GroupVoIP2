#ifndef __VIDEO_FFMPEG_ENCODER__H__
#define __VIDEO_FFMPEG_ENCODER__H__

extern "C" {
#include "libavcodec/avcodec.h"
#include "libavformat/avformat.h"
#include "libavutil/mathematics.h"
}
#include "VideoEncoder.h"

class VideoFfmpegEncoder:public VideoEncoder
{
 public:
    VideoFfmpegEncoder( VideoStreamSetting* setting, int vBaseLayerBitrate, VideoCodecId codecId );
    virtual ~VideoFfmpegEncoder();
    virtual SmartPtr<SmartBuffer> encodeAFrame(SmartPtr<SmartBuffer> input, bool* bIsKeyFrame);
 private:
    //AV_CODEC_ID_VP6
    AVCodec *codec_;
    AVCodecContext *context_;
    AVFrame *picture_;
    u32 totalFrames_;
    
    u32 nSize_;
};

#endif //__VIDEO_VP6_ENCODER__H__
