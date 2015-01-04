#include "AudioFdkaacEncoder.h"
#include "fwk/Units.h"

const u32 MAX_FDKAAC_ENCODED_BYTES = 8192;

AudioFdkaacEncoder::AudioFdkaacEncoder(AudioStreamSetting* outputSetting, int aBitrate):AudioEncoder(outputSetting, aBitrate), hEncoder_(NULL), bIsOpened_(false)
{
    if( outputSetting->acid == kAAC ) {
        if( aacEncOpen(&hEncoder_, 0, getNumChannels( outputSetting->at ) ) == AACENC_OK) {
            int aotMode = AOT_AAC_LC; // or 23 for low delay mode
            int bitrateMode = 0;
            if( aotMode == 23 ) {
                bitrateMode = 8;
            }
            //low delay mode = 23, does not play. AOT_AAC_LC plays fine in VLC.
            if (aacEncoder_SetParam(hEncoder_, AACENC_AOT, aotMode) != AACENC_OK) {
                LOG( "Unable to set the AOT\n");
            }
            if (aacEncoder_SetParam(hEncoder_, AACENC_BITRATE, aBitrate*1000) != AACENC_OK) {
                LOG( "Unable to set the VBR bitrate mode\n");
            }
            if (aacEncoder_SetParam(hEncoder_, AACENC_BITRATEMODE, bitrateMode) != AACENC_OK) {
                LOG( "Unable to set the VBR bitrate mode\n");
            }
            if (aacEncoder_SetParam(hEncoder_, AACENC_SAMPLERATE, getFreq( outputSetting->ar )) != AACENC_OK) {
                LOG( "Unable to set the sample rate\n");
            }
            if (aacEncoder_SetParam(hEncoder_, AACENC_CHANNELMODE, getNumChannels( outputSetting->at )) != AACENC_OK) {
                LOG( "Unable to set the channel mode\n");
            }
            if (aacEncoder_SetParam(hEncoder_, AACENC_CHANNELORDER, 0 ) != AACENC_OK) {
                LOG( "Unable to set the wav channel order\n");
            }
            //Make sure we set the transport type as 0: raw access units. 
            //Flash does not understand ADTS or other types of transport.
            if (aacEncoder_SetParam(hEncoder_, AACENC_TRANSMUX, 0 ) != AACENC_OK) {
                LOG( "Unable to set the transport type\n");
            }
            AACENC_ERROR error2;
            if ((error2 = aacEncEncode(hEncoder_, NULL, NULL, NULL, NULL)) != AACENC_OK) {
                LOG("aacEncEncode error");
            }
            AACENC_InfoStruct encInfo;
            if (aacEncInfo(hEncoder_, &encInfo) == AACENC_OK) {
                maxBuf_ = new SmartBuffer( MAX_FDKAAC_ENCODED_BYTES ); //max buffer
                LOG( "Fdkaac encoder created. freq=%d, channels=%d, AOT_AAC_LC=%d", 
                     getFreq( outputSetting->ar ), 
                     getNumChannels( outputSetting->at ),
                     AOT_AAC_LC );
                bIsOpened_ = true;
            } else {
                LOG("aacEncInfo error");
            }
        } else {
            LOG("FAILED to find Fdkaac encoder, FAILING." );
        }
    } else {
        LOG("FAILED to find Fdkaac codec, codecId=%d", outputSetting->acid );
        ASSERT(0);
    }
}

AudioFdkaacEncoder::~AudioFdkaacEncoder()
{
    if( hEncoder_ ) {
        // (4) Close Fdkaac engine
        aacEncClose(&hEncoder_);
        hEncoder_ = NULL;
    }
}

//details see http://wiki.multimedia.cx/index.php?title=MPEG-4_Audio
//Also http://wiki.multimedia.cx/?title=Understanding_AAC
SmartPtr<SmartBuffer> AudioFdkaacEncoder::genAudioHeader()
{ 
    u8 objectType = AOT_AAC_LC; //LC mode, not LD mode
    u8 frequencyIndex = 4; //always 44100
    u8 channelConfig = 2;//2 channels: front-left, front-right
    u8 otherConfig = 0; //1024 samples/frame
    
    SmartPtr<SmartBuffer> result = new SmartBuffer(2);
    if( result ) {
        u8* data = result->data();
        data[0] = (objectType<<3) | (frequencyIndex>>1);
        data[1] = (frequencyIndex<<7)|(channelConfig<<3)|otherConfig;
        //LOG("Fdkaac codec objectType=%d, frequencyIndex=%d, channelConfig=%d, data[0]=0x%x, data[1]=0x%x", objectType, frequencyIndex, channelConfig, data[0], data[1] );
    }
    return result;
}

SmartPtr<SmartBuffer> AudioFdkaacEncoder::encodeAFrame(SmartPtr<SmartBuffer> input) 
{
    SmartPtr<SmartBuffer> result = NULL;
    if( bIsOpened_ ) {
        u64 nInputSamples = input->dataLength()/sizeof(short);
        ASSERT( nInputSamples/getNumChannels( outputSetting_.at ) == AAC_FRAME_SAMPLE_SIZE );

        void* inBuffer[] = { input->data() };
        int inBufferIds[] = { IN_AUDIO_DATA };
        int inBufferSize[] = { (int)input->dataLength() };
        int inBufferElSize[]  = { sizeof(INT_PCM) };
        
        void* outBuffer[] = { maxBuf_->data() };
        int outBufferIds[] = { OUT_BITSTREAM_DATA };
        int outBufferSize[] = { (int)maxBuf_->dataLength()};
        int outBufferElSize[] = { sizeof(UCHAR) };

        AACENC_BufDesc inBufDesc = {0};
        AACENC_BufDesc outBufDesc = {0};
        inBufDesc.numBufs            = sizeof(inBuffer)/sizeof(void*);
        inBufDesc.bufs               = (void**)&inBuffer;
        inBufDesc.bufferIdentifiers  = inBufferIds;
        inBufDesc.bufSizes           = inBufferSize;
        inBufDesc.bufElSizes         = inBufferElSize;
        outBufDesc.numBufs           = sizeof(outBuffer)/sizeof(void*);
        outBufDesc.bufs              = (void**)&outBuffer;
        outBufDesc.bufferIdentifiers = outBufferIds;
        outBufDesc.bufSizes          = outBufferSize;
        outBufDesc.bufElSizes        = outBufferElSize;        

        AACENC_InArgs inargs = {0};
        AACENC_OutArgs outargs = {0};
        inargs.numInSamples = nInputSamples;
        int ErrorStatus = aacEncEncode(hEncoder_,
                                       &inBufDesc,
                                       &outBufDesc,
                                       &inargs,
                                       &outargs);;
        if( outargs.numOutBytes > 0 ) {
            result = new SmartBuffer( outargs.numOutBytes, maxBuf_->data() );
            //LOG( "SUCCESS encode audio fdkaac frame, size=%d, nInputSamples = %d\n", outargs.numOutBytes, nInputSamples);
        } else {
            LOG( "FAILED to encode audio fdkaac frame\n");
        }
    }
    return result;
}
