#ifndef __VIDEO_VP6_ENCODER__H__
#define __VIDEO_VP6_ENCODER__H__

extern "C" {
#include "libavcodec/avcodec.h"
#include "libavformat/avformat.h"
#include "libavutil/mathematics.h"
}
#include "VideoEncoder.h"

class VideoVp6Encoder:public VideoEncoder
{
 public:
    VideoVp6Encoder( VideoStreamSetting* setting, int vBaseLayerBitrate );
    virtual ~VideoVp6Encoder();
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
