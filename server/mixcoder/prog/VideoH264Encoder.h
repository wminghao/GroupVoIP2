#ifndef __VIDEOH264ENCODER_H__
#define __VIDEOH264ENCODER_H__

#include "VideoEncoder.h"

extern "C" {
#include <x264.h>
}

//video encoder implementation, x264 encoder   
class VideoH264Encoder:public VideoEncoder
{
 public:
    VideoH264Encoder( VideoStreamSetting* setting, int vBaseLayerBitrate );
    virtual ~VideoH264Encoder();
    virtual SmartPtr<SmartBuffer> encodeAFrame(SmartPtr<SmartBuffer> input, bool* bIsKeyFrame);
    virtual SmartPtr<SmartBuffer> genVideoHeader() {
        if( !videoHeaderGen_ ) {
            videoHeaderGen_ = true;
            return genVideoHeaderPrivate();
        } else {
            return NULL;
        }
    }

 private:
    SmartPtr<SmartBuffer> genVideoHeaderPrivate();
 private:
    //videoHeader
    bool videoHeaderGen_;

    //x264 parameters
    x264_param_t x264Param_;
    x264_t* x264Ctx_;    
    x264_picture_t x264Pic_; //input picture

    //saved spspps
    SmartPtr<SmartBuffer> h264Header_;

    u32 nSize_; //width*height

    //stats
    u32 frameInputCnt_;
    u32 frameOutputCnt_;
};
#endif
