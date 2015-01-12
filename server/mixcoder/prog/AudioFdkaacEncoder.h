#ifndef __AUDIO_FDKAAC_ENCODER__
#define __AUDIO_FDKAAC_ENCODER__

#include <fdk-aac/aacenc_lib.h>
#include "AudioEncoder.h"

//Faac encoder implementation
class AudioFdkaacEncoder:public AudioEncoder
{
 public:
    AudioFdkaacEncoder(AudioStreamSetting* outputSetting, int aBitrate);
    virtual ~AudioFdkaacEncoder();
    virtual SmartPtr<SmartBuffer> encodeAFrame(SmartPtr<SmartBuffer> input) ;
    virtual SmartPtr<SmartBuffer> genAudioHeader();
 private:
    u64 nMaxOutputBytes_;
    HANDLE_AACENCODER hEncoder_;
    bool bIsOpened_;
    SmartPtr<SmartBuffer> maxBuf_;
};
#endif //__AUDIO_FDKAAC_ENCODER__
