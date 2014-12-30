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
            pConfiguration->mpegVersion = MPEG4;
            pConfiguration->outputFormat = 0; //0 means RAW, 1 means ADTS_STREAM
            pConfiguration->inputFormat = FAAC_INPUT_16BIT;
            pConfiguration->aacObjectType = LOW;
            pConfiguration->allowMidside = 1;
            pConfiguration->shortctl =  0;//SHORTCTL_NORMAL;
            pConfiguration->useTns = 0;
            pConfiguration->bitRate = aBitrate*1000/getNumChannels( outputSetting->at ); //bits per second per channel
            
            // (2.2) Set encoding configuration
            int nRet = faacEncSetConfiguration(hEncoder_, pConfiguration);
            bIsOpened_ = (nRet != 0);
            if( bIsOpened_ ) {
                maxBuf_ = new SmartBuffer( nMaxOutputBytes_ ) ;
            }
            ASSERT( nInputSamples/getNumChannels( outputSetting->at ) == AAC_FRAME_SAMPLE_SIZE );
            LOG( "Faac encoder created. freq=%d, channels=%d, sampleSize=%ld, nMaxOutputBytes=%ld, bitrate=%d.", 
                 getFreq( outputSetting->ar ), 
                 getNumChannels( outputSetting->at ), 
                 nInputSamples/getNumChannels( outputSetting->at ), nMaxOutputBytes_,
                 pConfiguration->bitRate);
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
    u8 objectType = cfg->aacObjectType;
    u8 frequencyIndex = 4; //always 44100
    u8 channelConfig = 2;//2 channels: front-left, front-right
    u8 otherConfig = 0; //1024 samples/frame
    /*
    unsigned char *buffer = NULL;    
    unsigned long decoder_specific_info_size;
    if (!faacEncGetDecoderSpecificInfo(hEncoder_, &buffer,
                                       &decoder_specific_info_size)) {
        LOG("Faac codec decoder specific info, size =%d, buffer[0]=0x%x, buffer[1]=0x%x", decoder_specific_info_size, buffer[0], buffer[1]);
    }
    free(buffer);
    */
    
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
        u64 nInputSamples = input->dataLength()/sizeof(short);
        ASSERT( nInputSamples/getNumChannels( outputSetting_.at ) == AAC_FRAME_SAMPLE_SIZE );
        
        int nRet = faacEncEncode(hEncoder_, (int*)input->data(), nInputSamples, maxBuf_->data(), maxBuf_->dataLength());
        if( nRet > 0) {
            result = new SmartBuffer( nRet, maxBuf_->data() );
            //LOG( "SUCCESS encode audio faac frame, size=%d, nInputSamples = %d\n", nRet, nInputSamples);
            /*
            int enc_result = faacEncEncode(hEncoder_, NULL, 0, maxBuf_->data()+nRet, maxBuf_->dataLength()-nRet);
            if (enc_result > 0) {
                LOG( "SUCCESS FLUSH, size=%d", enc_result);
            }
            */
        } else if( nRet < 0 ){
            LOG( "FAILED to encode audio faac frame\n");
        } else {
            LOG( "AUDIO NO OUTPUT");
        }
    }
    return result;
}
