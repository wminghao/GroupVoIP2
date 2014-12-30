#ifndef __AUDIO_MP3_ENCODER_H__
#define __AUDIO_MP3_ENCODER_H__

#include "AudioEncoder.h"

struct lame_global_struct;
typedef struct lame_global_struct lame_global_flags;

#define MAX_MP3_ENCODED_BYTES MP3_FRAME_SAMPLE_SIZE*sizeof(short)*2 //max size 

//Speex encoder implementation
class AudioMp3Encoder:public AudioEncoder
{
 public:
    AudioMp3Encoder(AudioStreamSetting* outputSetting, int aBitrate);
    virtual ~AudioMp3Encoder();
    virtual SmartPtr<SmartBuffer> encodeAFrame(SmartPtr<SmartBuffer> input) ;
 private:
    lame_global_flags * lgf_;
    //audio encoder
    void* encoder_;
    char encodedBits_[MAX_MP3_ENCODED_BYTES];
};

#endif
