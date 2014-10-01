extern "C" {
#include <libavcodec/avcodec.h>    // required headers
#include <libavformat/avformat.h>
}

#include "VideoDecoder.h"
#include <assert.h>
#include "fwk/log.h"
            
VideoDecoder::~VideoDecoder() {
    reset();
}

void VideoDecoder::reset() {
    if( codecCtx_ ) {
        if( codecCtx_->extradata ) {
            free( codecCtx_->extradata );
            codecCtx_->extradata = 0;
        }
        avcodec_close( codecCtx_ );
        av_free( codecCtx_ );
        codecCtx_ = 0;
    }

    if( frame_ ) {
        av_free( frame_ );
        frame_ = 0;
    }
}

void VideoDecoder::initDecoder( SmartPtr<SmartBuffer> spspps ) {
    reset();

    AVCodecID codecId = CODEC_ID_H264;
    if( codecType_ == kAVCVideoPacket ) {
    } else if (codecType_ == kH263VideoPacket) {
        codecId = CODEC_ID_FLV1; //sorenson spark, details see http://en.wikipedia.org/wiki/Sorenson_Media#Encoding_Technologies
    } else {
        assert(0);
    }

    /* AVCodec/Decode init */
    codec_ = avcodec_find_decoder( codecId );
    if( ! codec_ ) {
        LOG("FAILED to find decoder, FAILING\n");
        exit(-1);
    }

    codecCtx_ = avcodec_alloc_context3( codec_ );
    if( ! codecCtx_ ) {
        LOG("FAILED to init decoder, FAILING2\n" );
        exit(-1);
    }
    
    /*
    codecCtx_->pix_fmt = PIX_FMT_YUV420P;
    if(codec_->capabilities&CODEC_CAP_TRUNCATED) {
        LOG("========>Truncated\n" );
        codecCtx_->flags|= CODEC_FLAG_TRUNCATED; // we do not send complete frames
    }
    */
    
    AVDictionary* d = 0;
    if( codecId == CODEC_ID_H264 ) {
        codecCtx_->extradata = (uint8_t*) malloc( spspps->dataLength() + FF_INPUT_BUFFER_PADDING_SIZE );
        memcpy( codecCtx_->extradata, spspps->data(), spspps->dataLength() );
        codecCtx_->extradata_size = spspps->dataLength();
    } else {
        codecCtx_->extradata_size = 0;
        codecCtx_->extradata = NULL;
    }

    if( avcodec_open2( codecCtx_, codec_, &d ) < 0 ) {
        LOG("FAILED to open decoder, FAILING3\n" );
    }

    LOG("===>video decoder created: codecType_=%d, cid1=%d, cid2=%d\r\n", codecType_, codecId, codecCtx_->codec->id);
    //TODO parse metadata to get width and height
    inWidth_ = 640;
    inHeight_ = 480; 

    frame_ = avcodec_alloc_frame();
    frame_->format = AV_PIX_FMT_YUV420P;
    frame_->width = inWidth_;
    frame_->height = inHeight_;
}

bool VideoDecoder::newAccessUnit( SmartPtr<AccessUnit> au, SmartPtr<VideoRawData> v)
{
    bool bIsValidFrame = false;
    assert( au->st == kVideoStreamType );
    assert( au->ctype == kAVCVideoPacket || au->ctype == kH263VideoPacket);

    //save the settings here
    v->sp = au->sp;
    v->pts = au->pts;

    //it can be a sps-pps header or regular nalu    
    if ( au->sp == kSpsPps ) {
        if( spspps_ 
            && spspps_->dataLength() == au->payload->dataLength() 
            && !memcmp( spspps_->data(), au->payload->data(), spspps_->dataLength()) ) {
            //LOG("Same video sps pps, ts=%d\n", au->pts);
        } else {
            bHasFirstFrameStarted_ = false;

            spspps_ = au->payload;
            initDecoder( spspps_ );
            //TODO parse sps/pps to get width and height, now assume it's 640*480
            inWidth_ = 640;
            inHeight_ = 480;
            v->rawVideoSettings_.vcid = kAVCVideoPacket;
            v->rawVideoSettings_.width = inWidth_;
            v->rawVideoSettings_.height =inHeight_; 
            bIsValidFrame = true;        

            LOG("StreamId=%d video decoded sps pps, len=%ld, ts=%d\n", streamId_, spspps_->dataLength(), au->pts);
        }
    } else if( au->sp == kRawData ) {
        if( codecType_ == kH263VideoPacket ) {
            if( !codec_ ) {
                initDecoder(SmartPtr<SmartBuffer>(NULL));
            }
        }

        bool bCanDecode = true;
        if( codecType_ == kAVCVideoPacket && !spspps_) {
            bCanDecode = false;
        }
        if ( bCanDecode ) {
            assert(inWidth_ && inHeight_);

            SmartPtr<SmartBuffer> buf = au->payload;

            //key frame must be combined with sps pps header
            if( codecType_ == kAVCVideoPacket && au->isKey ) {
                SmartPtr<SmartBuffer> totalBuf = new SmartBuffer( buf->dataLength() + spspps_->dataLength() );
                memcpy( totalBuf->data(), spspps_->data(), spspps_->dataLength() );
                memcpy( totalBuf->data() + spspps_->dataLength(), buf->data(), buf->dataLength() );
                buf = totalBuf;
            } 
            
            AVPacket pkt;
            av_init_packet( &pkt );
            pkt.size = buf->dataLength();
            pkt.data = buf->data();

            int gotPic = 0;
            int rval;

            /*
            int stride_align[8];
            for (int i = 0; i < 8; i++) {
                stride_align[i] = 8;
            }
            avcodec_align_dimensions2(codecCtx_, &inWidth_, &inHeight_, stride_align);
            */
            if( ( rval = avcodec_decode_video2( codecCtx_, frame_, &gotPic, &pkt ) ) > 0) {
                if( gotPic ) {
                    assert(inWidth_ == frame_->width);
                    assert(inHeight_ == frame_->height);

                    int uvHeight = inHeight_/2; //422 vs. 420

                    //copy 3 planes and 3 strides
                    v->rawVideoPlanes_[0] = new SmartBuffer( frame_->linesize[0]*inHeight_, frame_->data[0]);
                    v->rawVideoPlanes_[1] = new SmartBuffer( frame_->linesize[1]*uvHeight, frame_->data[1]);
                    v->rawVideoPlanes_[2] = new SmartBuffer( frame_->linesize[2]*uvHeight, frame_->data[2]);
                    /*
                    LOG( "video decoded pkt isKey=%d size=%d decoded=%d stride0=%d, stride1=%d, stride2=%d, width=%d, height=%d, ts=%d, streamId_=%d, data0=0x%x, data1=0x%x, data2=0x%x, data2To=0x%x\n", 
                         au->isKey, pkt.size, rval,
                         frame_->linesize[0], frame_->linesize[1], frame_->linesize[2],
                         frame_->width, frame_->height, au->pts, streamId_, 
                         frame_->data[0], frame_->data[1], frame_->data[2]);
                    */
                    memcpy(v->rawVideoStrides_, frame_->linesize, sizeof(int)*3);

                    v->rawVideoSettings_.vcid = codecType_;
                    v->rawVideoSettings_.width = inWidth_;
                    v->rawVideoSettings_.height = inHeight_; 

                    bIsValidFrame = true;
                    if( !bHasFirstFrameStarted_ ) {
                        bHasFirstFrameStarted_ = true;
                        firstFramePts_ = au->pts;
                    }
                } else {
                    LOG( "DIDNT get video frame\n");
                }
            } else if ( rval == 0 ) {
                LOG( "NO FRAME!\n");
            } else {
                LOG( "DECODE ERROR!\n");
            }
        }
    }
    return bIsValidFrame;
}
