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


//assume there is only one slice per frame
bool isKeyFrame(u8* data, int len)
{
    bool bIsKeyFrame = false;
    if( len >= 5 ) {
        u8 NALuHeader = data[4];//excluding the 4 bytes len
        u8 nal_unit_type = (u8)((NALuHeader>>0) & 0x1f);
        u8 nal_ref_idc =  (u8)((NALuHeader>>5) & 0x03);
        
        bIsKeyFrame = ( nal_unit_type == 5 );
    }
    return bIsKeyFrame;
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
        int payloadSize;    

        payloadSize = x264_encoder_encode(x264Ctx_, &nals, &i_nal, &x264Pic_, &outPic );
        if( payloadSize >= 5 && i_nal == 1) {
            assert(nals[0].i_payload == payloadSize);
            assert(nals[0].p_payload[0]==0);
            assert(nals[0].p_payload[1]==0);
            assert(nals[0].p_payload[2]==0);
            assert(nals[0].p_payload[3]==1);
            //Replace 00 00 00 01 with NAL length in big endian
            nals[0].p_payload[0] = (payloadSize-4) >> 24;
            nals[0].p_payload[1] = ((payloadSize-4) >> 16) & 0xff;
            nals[0].p_payload[2] = ((payloadSize-4) >> 8) & 0xff;
            nals[0].p_payload[3] = ((payloadSize-4) >> 0) & 0xff;
            *bIsKeyFrame = isKeyFrame( nals[0].p_payload, nals[0].i_payload );
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
