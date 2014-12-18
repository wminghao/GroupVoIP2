#ifndef __AUDIO_SPEEX_ENCODER_H__
#define __AUDIO_SPEEX_ENCODER_H__

#include "AudioEncoder.h"
#include <speex/speex.h>

//Speex encoder implementation
class AudioSpeexEncoder:public AudioEncoder
{
 public:
    //always encode in speex or mp3
    AudioSpeexEncoder(AudioStreamSetting* outputSetting, int aBitrate);
    virtual ~AudioSpeexEncoder();
    virtual SmartPtr<SmartBuffer> encodeAFrame(SmartPtr<SmartBuffer> input) ;
 private:
    SpeexBits bits_;

    //audio encoder
    void* encoder_;
    char encodedBits_[MAX_ENCODED_BYTES];
    int frameSize_;
};

#endif
