#include "AudioFaacEncoder.h"
#include "fwk/Units.h"

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
