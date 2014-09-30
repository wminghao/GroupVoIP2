#include "VideoFfmpegEncoder.h"
#include "fwk/log.h"
#include "CodecInfo.h"
#include <stdio.h>
#include <stdlib.h>

VideoFfmpegEncoder::VideoFfmpegEncoder( VideoStreamSetting* setting, int vBaseLayerBitrate, VideoCodecId codecId ):VideoEncoder(setting, vBaseLayerBitrate)
{
    /* register all the codecs */
    av_register_all();

    /* find the vp6 video encoder */
    AVCodecID codecType = AV_CODEC_ID_VP6F;
    if( codecId == kH263VideoPacket) {
        codecType = AV_CODEC_ID_FLV1;
    }

    codec_ = avcodec_find_encoder(codecType);
    if ( !codec_ ) {
        LOG( "ffmpeg codec not found, codecType=%d\n", codecType);
        exit(1);
    }
    context_ = avcodec_alloc_context3(codec_);
    picture_ = avcodec_alloc_frame();
    
    /* put sample parameters */
    context_->bit_rate = vBaseLayerBitrate*1024; //kbps
    /* resolution must be a multiple of two */
    context_->width = setting->width;
    context_->height = setting->height;
    /* frames per second */
    context_->time_base= (AVRational){1,30};
    context_->gop_size = 30; /* emit one intra frame every ten frames */
    context_->pix_fmt = PIX_FMT_YUV420P;
    
    nSize_ = context_->width * context_->height;

    /* open it */
    if ( avcodec_open2(context_, codec_, NULL) < 0 ) {
        LOG("could not open ffmpeg codec\n");
        exit(1);
    }    
}

VideoFfmpegEncoder::~VideoFfmpegEncoder()
{
    avcodec_close(context_);
    av_free(context_);
    av_free(picture_);
}

SmartPtr<SmartBuffer> VideoFfmpegEncoder::encodeAFrame(SmartPtr<SmartBuffer> input, bool* bIsKeyFrame)
{
    SmartPtr<SmartBuffer> result;
    if ( input && input->dataLength() > 0 ) {
        picture_->data[0] = input->data();
        picture_->data[1] = picture_->data[0] + nSize_;
        picture_->data[2] = picture_->data[1] + nSize_ / 4;
        picture_->linesize[0] = context_->width;
        picture_->linesize[1] = context_->width / 2;
        picture_->linesize[2] = context_->width / 2;
        
        /* encode the image */
        AVPacket pkt;
        av_init_packet(&pkt);
        pkt.data = NULL;    // packet data will be allocated by the encoder
        pkt.size = 0;

        int gotPkt;
        int ret = avcodec_encode_video2(context_, &pkt, picture_, &gotPkt);
        if( ret >= 0 && gotPkt ) {
            *bIsKeyFrame = context_->coded_frame->key_frame;

            totalFrames_++;
            //LOG("encoding frame %3d (size=%5d)\n", totalFrames_, pkt.size);
            result = new SmartBuffer( pkt.size, pkt.data );
            av_free_packet(&pkt);
        } else {
            LOG("----------failed to decode, out_size=%d, input->dataLength()=%d, gotPkt=%d", ret, input->dataLength(), gotPkt);
        }
    }
    return result;
}
