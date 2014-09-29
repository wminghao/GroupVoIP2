#include "VideoVp6Encoder.h"
#include "fwk/log.h"
#include <stdio.h>
#include <stdlib.h>

VideoVp6Encoder::VideoVp6Encoder( VideoStreamSetting* setting, int vBaseLayerBitrate ):VideoEncoder(setting, vBaseLayerBitrate)
{
    /* find the vp6 video encoder */
    codec_ = avcodec_find_encoder(CODEC_ID_VP6);
    if (!codec_) {
        LOG( "VP6 codec not found\n");
        exit(1);
    }
    context_ = avcodec_alloc_context3(codec_);
    picture_ = avcodec_alloc_frame();
    
    /* put sample parameters */
    context_->bit_rate = vBaseLayerBitrate*3*1024; //300kbps
    /* resolution must be a multiple of two */
    context_->width = 640;
    context_->height = 480;
    /* frames per second */
    context_->time_base= (AVRational){1,30};
    context_->gop_size = 30; /* emit one intra frame every ten frames */
    context_->pix_fmt = PIX_FMT_YUV420P;
    
    nSize_ = context_->width * context_->height;

    /* open it */
    if ( avcodec_open2(context_, codec_, NULL) < 0 ) {
        LOG("could not open VP6 codec\n");
        exit(1);
    }    
}

VideoVp6Encoder::~VideoVp6Encoder()
{
    avcodec_close(context_);
    av_free(context_);
    av_free(picture_);
}

SmartPtr<SmartBuffer> VideoVp6Encoder::encodeAFrame(SmartPtr<SmartBuffer> input, bool* bIsKeyFrame)
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
        int gotPkt;
        int out_size = avcodec_encode_video2(context_, &pkt, picture_, &gotPkt);
        if( out_size > 0 && gotPkt ) {
            totalFrames_++;
            LOG("encoding frame %3d (size=%5d)\n", totalFrames_, out_size);
            result = new SmartBuffer( pkt.size, pkt.data );
            av_free_packet(&pkt);
        }
    }
    return result;
}
