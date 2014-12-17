#ifndef __AUDIODECODERFACTORY_H
#define __AUDIODECODERFACTORY_H
#include "fwk/SmartPtr.h"
#include "AccessUnit.h"
#include "CodecInfo.h"

class AudioDecoder;

class AudioDecoderFactory
{
 public:
    static AudioDecoder* CreateAudioDecoder(const SmartPtr<AccessUnit> au, int streamId, AudioCodecId outputCodecId);
    static bool isSameDecoder(const SmartPtr<AccessUnit> au, const AudioStreamSetting* origSetting);
};
#endif
