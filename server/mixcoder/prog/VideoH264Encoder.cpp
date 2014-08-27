#include "VideoH264Encoder.h"
#include "fwk/log.h"
#include <assert.h>

VideoH264Encoder::VideoH264Encoder( VideoStreamSetting* setting, int vBaseLayerBitrate ):VideoEncoder(setting, vBaseLayerBitrate), frameInputCnt_(0), frameOutputCnt_(0)
{  
    int outBitrate = vBaseLayerBitrate * 3;//TODO 3 times the base is the output bitrate

    x264_param_default(&x264Param_);
    x264_param_default_preset(&x264Param_, "medium", "zerolatency");
    x264_param_apply_profile(&x264Param_, "baseline");
    x264Param_.b_cabac = 0;
    x264Param_.rc.i_rc_method = X264_RC_ABR;
    x264Param_.b_sliced_threads = 0;
    
    x264Param_.i_width = setting->width;
    x264Param_.i_height = setting->height;
    x264Param_.i_fps_num = 30;
    x264Param_.i_fps_den = 1;
    x264Param_.i_keyint_min = 30;
    x264Param_.i_keyint_max = 30;

    x264Param_.b_repeat_headers = 0;
    x264Param_.rc.i_bitrate = outBitrate; 
    x264Param_.rc.i_vbv_max_bitrate = outBitrate;
    x264Param_.rc.i_vbv_buffer_size = outBitrate * 2;
    x264Param_.i_level_idc = 30;

    x264Param_.b_annexb = 0;

    x264Param_.i_threads = 1;
    x264Param_.i_frame_reference = 1;
    //x264Param_.i_dpb_size = 1;
    x264Param_.b_sliced_threads = 0;
    x264Param_.i_slice_count = 1; //generating 1 nalu per frame

    x264Ctx_ = x264_encoder_open( & x264Param_ );
    if( !x264Ctx_ ) {
        LOG("---Error cannot create x264 context");
        assert(0);
    }

    x264_picture_init( &x264Pic_ );
    x264Pic_.img.i_csp = X264_CSP_I420;
    x264Pic_.img.i_plane = 3; //3 planes in one buffer

    x264Pic_.img.i_stride[0] = setting->width;
    x264Pic_.img.i_stride[1] = setting->width/2;
    x264Pic_.img.i_stride[2] = setting->width/2;
    
    x264Pic_.i_type = X264_TYPE_AUTO; //Auto select TODO

    nSize_ = setting->width*setting->height;
}

VideoH264Encoder::~VideoH264Encoder()
{
    if( x264Ctx_ ) {
        x264_encoder_close( x264Ctx_ );
        x264Ctx_ = 0;
    }
}

SmartPtr<SmartBuffer> VideoH264Encoder::encodeAFrame(SmartPtr<SmartBuffer> input, bool* bIsKeyFrame)
{
    SmartPtr<SmartBuffer> result;
    if ( input && input->dataLength() > 0 ) {
        frameInputCnt_++;

        x264Pic_.img.plane[0] = input->data();
        x264Pic_.img.plane[1] = x264Pic_.img.plane[0] + nSize_;
        x264Pic_.img.plane[2] = x264Pic_.img.plane[1] + nSize_ / 4;        
        
        x264_picture_t outPic;
        x264_nal_t *nals;
        int i_nal;
        int rv;    

        rv = x264_encoder_encode(x264Ctx_, &nals, &i_nal, &x264Pic_, &outPic );
        if( rv > 0 && i_nal == 1) {
            frameOutputCnt_++;
            result = new SmartBuffer( nals[0].i_payload, nals[0].p_payload );
        } else {
            LOG("===h264 encode error!");
        }
    }
    return result;
}

//TODO missing
//spspps header generation, attach to each key frame???
//how to determine keyframes???
