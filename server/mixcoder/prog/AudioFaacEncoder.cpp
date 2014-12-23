#include "AudioFaacEncoder.h"
#include "fwk/Units.h"
#include <libavcodec/avcodec.h>

AudioFaacEncoder::AudioFaacEncoder(AudioStreamSetting* outputSetting, int aBitrate):AudioEncoder(outputSetting, aBitrate), hEncoder_(NULL), bIsOpened_(false)
{
    if( outputSetting->acid == kAAC ) {
        u64 nInputSamples = 0;
        
        // (1) Open FAAC engine
        hEncoder_ = faacEncOpen( getFreq( outputSetting->ar ), 
                                getNumChannels( outputSetting->at ), 
                                &nInputSamples, &nMaxOutputBytes_);    
        if( hEncoder_ ) {
            faacEncConfigurationPtr pConfiguration;
            pConfiguration = faacEncGetCurrentConfiguration(hEncoder_);
            pConfiguration->inputFormat = FAAC_INPUT_16BIT;
            pConfiguration->aacObjectType = FF_PROFILE_AAC_LOW;

            // (2.2) Set encoding configuration
            int nRet = faacEncSetConfiguration(hEncoder_, pConfiguration);
            bIsOpened_ = (nRet != 0);
            if( bIsOpened_ ) {
                maxBuf_ = new SmartBuffer( nMaxOutputBytes_) ;
            }
            LOG("Faac encoder created. nInputSamples=%ld, nMaxOutputBytes=%ld.", nInputSamples, nMaxOutputBytes_ );
        } else {
            LOG("FAILED to find Faac encoder, FAILING." );
        }
    } else {
        LOG("FAILED to find Faac codec, codecId=%d", outputSetting->acid );
        ASSERT(0);
    }
}

AudioFaacEncoder::~AudioFaacEncoder()
{
    if( hEncoder_ ) {
        // (4) Close FAAC engine
        faacEncClose(hEncoder_);
        hEncoder_ = NULL;
    }
}

//details see http://wiki.multimedia.cx/index.php?title=MPEG-4_Audio
//Also http://wiki.multimedia.cx/?title=Understanding_AAC
SmartPtr<SmartBuffer> AudioFaacEncoder::genAudioHeader()
{
    faacEncConfigurationPtr cfg = faacEncGetCurrentConfiguration(hEncoder_);
    u8 objectType = 0;
    switch( cfg->aacObjectType ) {
    case FF_PROFILE_AAC_MAIN:
        {
            objectType = 1;
            break;
        }
        
    case FF_PROFILE_UNKNOWN:
    case FF_PROFILE_AAC_LOW:
        {
            objectType = 2;
            break;
        }
    case FF_PROFILE_AAC_SSR:
        {
            objectType = 3;
            break;
        }
    case FF_PROFILE_AAC_LTP:
        {
            objectType = 4;
            break;
        }
    default:
        {
            ASSERT(0);
        }
    }

    u8 frequencyIndex = 4; //always 44100
    u8 channelConfig = 2;//2 channels: front-left, front-right
    u8 otherConfig = 0; //1024 samples/frame

    SmartPtr<SmartBuffer> result = new SmartBuffer(2);
    if( result ) {
        u8* data = result->data();
        data[0] = (objectType<<3) | (frequencyIndex>>1);
        data[1] = (frequencyIndex<<7)|(channelConfig<<3)|otherConfig;
        //LOG("Faac codec objectType=%d, frequencyIndex=%d, channelConfig=%d, data[0]=0x%x, data[1]=0x%x", objectType, frequencyIndex, channelConfig, data[0], data[1] );
    }
    return result;
}

SmartPtr<SmartBuffer> AudioFaacEncoder::encodeAFrame(SmartPtr<SmartBuffer> input) 
{
    SmartPtr<SmartBuffer> result = NULL;
    if( bIsOpened_ ) {
        u64 nInputSamples = input->dataLength()/(sizeof(short)*getNumChannels( outputSetting_.at ));

        int nRet = faacEncEncode(hEncoder_, (int*)input->data(), nInputSamples, maxBuf_->data(), nMaxOutputBytes_);
        if( nRet > 0) {
            result = new SmartBuffer( nRet, maxBuf_->data() );
            LOG( "SUCCESS encode audio faac frame, size=%d\n", nRet);
        } else {
            LOG( "FAILED to encode audio faac frame\n");
        }
    }
    return result;
}
