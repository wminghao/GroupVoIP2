#ifndef __VIDEOVP8ENCODER_H__
#define __VIDEOVP8ENCODER_H__

#include "VideoEncoder.h"

//ensure strict compliance with the latest SDK by disabling some backwards compatibility features.
#define VPX_CODEC_DISABLE_COMPAT
#include "vpx/vpx_encoder.h"
#include "vpx/vp8cx.h"

#define VPX_TS_MAX_PERIODICITY 16
//we choose to use 5 layers of temporal scalability
#define NUM_LAYERS 5

//#define DEBUG_SAVE_IVF

//video encoder implementation, vp8 encoder   
class VideoVp8Encoder:public VideoEncoder
{
 public:
    VideoVp8Encoder( VideoStreamSetting* setting, int vBaseLayerBitrate );
    virtual ~VideoVp8Encoder();
    virtual SmartPtr<SmartBuffer> encodeAFrame(SmartPtr<SmartBuffer> input, bool* bIsKeyFrame);

 private:
    vpx_codec_ctx_t      codec_;
    vpx_codec_enc_cfg_t  cfg_;

    vpx_image_t          raw_;
    int                  layerFlags_[VPX_TS_MAX_PERIODICITY];

    int                  frameInputCnt_;
    int                  frameOutputCnt_;
    u32                  timestampTick_;
        
#ifdef DEBUG_SAVE_IVF
    FILE* outFile_[NUM_LAYERS];
#endif
};
#endif
