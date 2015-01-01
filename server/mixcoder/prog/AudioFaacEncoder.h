#ifndef __AUDIO_FAAC_ENCODER__
#define __AUDIO_FAAC_ENCODER__

#include <faac.h>
#include "AudioEncoder.h"

//Faac encoder implementation
class AudioFaacEncoder:public AudioEncoder
{
 public:
    AudioFaacEncoder(AudioStreamSetting* outputSetting, int aBitrate);
    virtual ~AudioFaacEncoder();
    virtual SmartPtr<SmartBuffer> encodeAFrame(SmartPtr<SmartBuffer> input) ;
    virtual SmartPtr<SmartBuffer> genAudioHeader();
 private:
    u64 nMaxOutputBytes_;
    faacEncHandle hEncoder_;
    bool bIsOpened_;
    bool bIsStarted_; //get rif of aac 3 frame dealy in the beginning
    SmartPtr<SmartBuffer> maxBuf_;
};
#endif //__AUDIO_FAAC_ENCODER__
