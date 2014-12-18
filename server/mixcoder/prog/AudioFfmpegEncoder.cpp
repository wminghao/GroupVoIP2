#include "AudioFfmpegEncoder.h"
#include "fwk/Units.h"

extern "C" {
#include <libavcodec/avcodec.h>    // required headers
#include <libavformat/avformat.h>
}

AudioFfmpegEncoder::AudioFfmpegEncoder(AudioStreamSetting* outputSetting, int aBitrate):AudioEncoder(outputSetting, aBitrate), encodeCodec_(NULL), encodeContext_(NULL), encodeFrame_(NULL), bIsOpened_(false)
{
    if( outputSetting->acid == kAAC ) {
        avcodec_register_all();
        /* AVCodec/Encode init */
        encodeCodec_ = avcodec_find_encoder( CODEC_ID_AAC );
        if( encodeCodec_ ) {
            encodeContext_ = avcodec_alloc_context3( encodeCodec_ );
            if( encodeContext_ ) {
                encodeFrame_ = avcodec_alloc_frame();
                if( encodeFrame_ ) {
                    encodeContext_->bit_rate = aBitrate * 1000;
                    encodeContext_->sample_rate = getFreq( outputSetting->ar );
                    encodeContext_->channels = getNumChannels( outputSetting->at );
                    encodeContext_->sample_fmt = AV_SAMPLE_FMT_S16; //AV_SAMPLE_FMT_FLTP; (PCM 32bit Float Planar), AV_SAMPLE_FMT_S16P(Planar 32bit PCM)
                    encodeContext_->profile = FF_PROFILE_AAC_LOW;
                    encodeContext_->strict_std_compliance = FF_COMPLIANCE_EXPERIMENTAL; //to avoid the error "aac codec is experimental but experimental codecs are not enabled"
                    //encodeContext_->->codec_type = 1;
                    encodeContext_->channel_layout = AV_CH_LAYOUT_STEREO;
                                            
                    AVDictionary *opts = NULL; 
                    av_dict_set(&opts, "strict", "experimental", 0); 
                    if( avcodec_open2( encodeContext_, encodeCodec_, &opts ) >= 0 ) {
                        encodeFrame_->nb_samples     = encodeContext_->frame_size;
                        encodeFrame_->format         = encodeContext_->sample_fmt;                        
                        encodeFrame_->channel_layout = encodeContext_->channel_layout;
                        bIsOpened_ = true;
                        OUTPUT("SUCCESSFULLY opened ffmpeg audio codec" );
                    } else {
                        OUTPUT("FAILED to open Ffmpeg encoder!, FAILING." );
                    }
                    av_dict_free(&opts); 
                } else {
                    OUTPUT("FAILED to alloc encode Ffmpeg frame!, FAILING." );
                }
            } else {
                OUTPUT( "FAILED to init Ffmpeg encoder, FAILING." );
            }
        } else {
            OUTPUT("FAILED to find Ffmpeg encoder, FAILING." );
        }
    } else {
        OUTPUT("FAILED to find Ffmpeg codec, codecId=%d", outputSetting->acid );
        //don't support other codecs yet.
        ASSERT(0);
    }
}

AudioFfmpegEncoder::~AudioFfmpegEncoder()
{
    if( encodeContext_ ) {
        avcodec_close( encodeContext_ );
        av_free( encodeContext_ );
        encodeContext_ = NULL;
    }

    if( encodeFrame_ ) {
        av_free( encodeFrame_ );
        encodeFrame_ = NULL;
    }
}

SmartPtr<SmartBuffer> AudioFfmpegEncoder::encodeAFrame(SmartPtr<SmartBuffer> input) 
{
    SmartPtr<SmartBuffer> result = NULL;
    if( encodeContext_ && encodeFrame_ && encodeCodec_ && bIsOpened_ ) {
        AVPacket encodeOutputPkt;
        av_init_packet( &encodeOutputPkt );
        encodeOutputPkt.data = 0;
        encodeOutputPkt.size = 0;
        encodeFrame_->data[0] = (unsigned char*) input->data();

        int gotFrame = 0;
        if( !avcodec_encode_audio2( encodeContext_, &encodeOutputPkt,
                                    encodeFrame_, &gotFrame ) )  {
            if( gotFrame ) {
                int adtsHeaderSize = 7; 
                if ( encodeOutputPkt.size > adtsHeaderSize ) {
                    //for aac audio, ffmpeg automatically generates 7 bytes ADTS header on top of the raw data
                    result = new SmartBuffer( encodeOutputPkt.size - adtsHeaderSize,
                                              encodeOutputPkt.data + adtsHeaderSize );
                    OUTPUT("SUCCESSFULLY encoded an ffmpeg audio frame, size =%d", encodeOutputPkt.size );
                } else {
                    OUTPUT("Ffmpeg Audio frame size too small!\n");
                }
            } else {
                OUTPUT("DIDNT get audio ffmpeg frame\n");
            }
        } else {
            OUTPUT( "FAILED to encode audio ffmpeg frame\n");
        }
        av_free_packet( &encodeOutputPkt );
    }
    return result;
}
