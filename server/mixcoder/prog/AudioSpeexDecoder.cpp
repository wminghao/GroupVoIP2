#include "AudioSpeexDecoder.h"
#include "fwk/log.h"
#include "fwk/Units.h"
#include <stdio.h>

AudioSpeexDecoder::~AudioSpeexDecoder()
{
    speex_bits_destroy(&bits_);
    if( decoder_ ) {
        speex_decoder_destroy(decoder_); 
        decoder_ = NULL;
    }
    if( outputFrame_ ) {
        free(outputFrame_);
        outputFrame_ = NULL;
    }
}

void AudioSpeexDecoder::newAccessUnit( SmartPtr<AccessUnit> au , AudioStreamSetting* aRawSetting)
{
    ASSERT(au->st == kAudioStreamType);
    
    if( decoder_ && outputFrame_ && au && au->payload ) { 
        speex_bits_read_from(&bits_, (char*)au->payload->data(), au->payload->dataLength());
        speex_decode_int(decoder_, &bits_, outputFrame_);

        //Don't return the result immediately, go through the resampler
        //result = new SmartBuffer( sampleSize_ * sizeof(u16), (u8*)outputFrame_);

        //LOG( "audio decoded pkt size=%ld sample size=%d ts=%d, streamId=%d\n", au->payload->dataLength(), sampleSize_, au->pts, streamId_);
        hasFirstFrameDecoded_ = true;
        
        //send to resampler
        resampleFrame( aRawSetting, sampleSize_, (u8*)outputFrame_ );
    }
}
