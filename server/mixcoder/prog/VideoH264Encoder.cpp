#include "VideoH264Encoder.h"
#include "fwk/log.h"
#include "fwk/Units.h"

VideoH264Encoder::VideoH264Encoder( VideoStreamSetting* setting, int vBaseLayerBitrate ):VideoEncoder(setting, vBaseLayerBitrate), videoHeaderGen_(false), frameInputCnt_(0), frameOutputCnt_(0)
{  
    int outBitrate = vBaseLayerBitrate;

    x264_param_default(&x264Param_);
    x264_param_default_preset(&x264Param_, "medium", "zerolatency");
    x264_param_apply_profile(&x264Param_, "baseline");
    x264Param_.b_cabac = 0;
    x264Param_.rc.i_rc_method = X264_RC_ABR;
    x264Param_.b_sliced_threads = 0;
    
    x264Param_.i_width = setting->width;
    x264Param_.i_height = setting->height;
    x264Param_.i_fps_num = OUTPUT_VIDEO_FRAME_RATE;
    x264Param_.i_fps_den = 1;
    x264Param_.i_keyint_min = OUTPUT_VIDEO_FRAME_RATE;
    x264Param_.i_keyint_max = OUTPUT_VIDEO_FRAME_RATE;

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
        ASSERT(0);
    }

    x264_picture_init( &x264Pic_ );
    x264Pic_.img.i_csp = X264_CSP_I420;
    x264Pic_.img.i_plane = 3; //3 planes in one buffer

    x264Pic_.img.i_stride[0] = setting->width;
    x264Pic_.img.i_stride[1] = setting->width/2;
    x264Pic_.img.i_stride[2] = setting->width/2;
    
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
        if( !(frameInputCnt_ % OUTPUT_VIDEO_FRAME_RATE)) {
            x264Pic_.i_type = X264_TYPE_IDR;
        } else {
            x264Pic_.i_type = X264_TYPE_P;
        }

        x264Pic_.img.plane[0] = input->data();
        x264Pic_.img.plane[1] = x264Pic_.img.plane[0] + nSize_;
        x264Pic_.img.plane[2] = x264Pic_.img.plane[1] + nSize_ / 4;        

        frameInputCnt_++;

        x264_picture_t outPic;
        x264_nal_t *nals;
        int numNalus;
        int payloadSize;    

        payloadSize = x264_encoder_encode(x264Ctx_, &nals, &numNalus, &x264Pic_, &outPic );
        if( payloadSize >= 5 && numNalus == 1) {
            ASSERT(nals[0].i_payload == payloadSize);

            /*
            //Replace 00 00 00 01 with NAL length in big endian
            nals[0].p_payload[0] = (payloadSize-4) >> 24;
            nals[0].p_payload[1] = ((payloadSize-4) >> 16) & 0xff;
            nals[0].p_payload[2] = ((payloadSize-4) >> 8) & 0xff;
            nals[0].p_payload[3] = ((payloadSize-4) >> 0) & 0xff;
            */
            *bIsKeyFrame = ((nals[0].p_payload[4] & 0x1f)==5);
            frameOutputCnt_++;

            //LOG("===h264 cnt=%d len=%d nals[0].i_payload=%d isKeyframe=%d!\r\n", frameOutputCnt_, payloadSize, nals[0].i_payload, *bIsKeyFrame);
            result = new SmartBuffer( nals[0].i_payload, nals[0].p_payload );
        } else {
            LOG("===h264 encode error!!!");
        }
    }
    return result;
}

SmartPtr<SmartBuffer> VideoH264Encoder::genVideoHeaderPrivate()
{
    SmartPtr<SmartBuffer> header = NULL;
    SmartPtr<SmartBuffer> sps;
    SmartPtr<SmartBuffer> pps;
    x264_nal_t *nals;
    int nalCnt;
    x264_encoder_headers( x264Ctx_, &nals, &nalCnt );
    for( int i = 0; i < nalCnt; i++ ) {
        if( nals[i].i_type == NAL_SPS ) {
            sps= new SmartBuffer( nals[i].i_payload-4, nals[i].p_payload+4 );
        } else if (nals[i].i_type == NAL_PPS ) {
            pps= new SmartBuffer( nals[i].i_payload-4, nals[i].p_payload+4 );
        }
    }
    if( sps && pps ) {
        u32 spsLen = sps->dataLength();
        u32 ppsLen = pps->dataLength();

        //FLV's sps pps header, details in FLV video format doc
        header = new SmartBuffer( spsLen + ppsLen + 11);
        u8* data = header->data();
        //Version
        data[0] = 0x01;

        //profile&level
        data[1] = sps->data()[1];
        data[2] = sps->data()[2];
        data[3] = sps->data()[3];

        //reserved
        data[4] = (u8)0xff;
        data[5] = (u8)0xe1;

        //sps_size&data
        data[6] = (u8)(spsLen >> 8);
        data[7] = (u8)(spsLen & 0xFF);
        memcpy(&data[8], sps->data(), spsLen);

        //pps_size&data
        data[8+spsLen] = 0x01;
        data[9+spsLen] = (u8)(ppsLen >> 8);
        data[10+spsLen] = (u8)(ppsLen & 0xFF);
        memcpy(&data[11+spsLen], pps->data(), ppsLen);

        //LOG("===h264 built spspps, sps1stbyte=0x%x, pps1stbyte=0x%x, spsLen=%d, ppsLen=%d, len = %d\r\n", data[8], data[11+spsLen], spsLen, ppsLen, (spsLen+ppsLen+11));
    }
    return header;
}

