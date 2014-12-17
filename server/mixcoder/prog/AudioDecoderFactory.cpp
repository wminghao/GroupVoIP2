#include "AudioDecoderFactory.h"    
#include "fwk/SmartPtr.h"
#include "fwk/SmartBuffer.h"
#include "fwk/Units.h"
#include "AudioSpeexDecoder.h"
#include "AudioFfmpegDecoder.h"
#include "fwk/log.h"

AudioDecoder* AudioDecoderFactory::CreateAudioDecoder(const SmartPtr<AccessUnit> au, int streamId, AudioCodecId outputCodecId)
{
    AudioDecoder* decoder = NULL;
    if( au ) {
        unsigned char firstByte = au->ctype;
        AudioCodecId codecType = (AudioCodecId)((firstByte & 0xf0)>>4);
        AudioRate audioRate = (AudioRate)((firstByte & 0x0c)>>2);
        AudioSize audioSize = (AudioSize)((firstByte & 0x02)>>1);
        AudioType audioType = (AudioType)(firstByte & 0x01);
 
        //LOG("AudioDecoderFactory::CreateAudioDecoder: firstByte=0x%x, codecType=%d, audioRate=%d, audioSize=%d, audioType=%d\r\n", firstByte, codecType, audioRate, audioSize, audioType);
       
        if( codecType == kSpeex ) {
            decoder = new AudioSpeexDecoder(streamId, 
                                            kSpeex,
                                            k16kHz, //audioRate is 0, but it's 16khz
                                            kSnd16Bit,
                                            kSndMono,
                                            outputCodecId);
        } else {
            decoder = new AudioFfmpegDecoder(streamId, 
                                            codecType,
                                            audioRate,
                                            audioSize,
                                            audioType,
                                            outputCodecId);
        }
    }
    return decoder;
}

bool AudioDecoderFactory::isSameDecoder(const SmartPtr<AccessUnit> au, const AudioStreamSetting* origSetting)
{
    if( au && origSetting ) {
        unsigned char firstByte = au->ctype;
        AudioCodecId codecType = (AudioCodecId)((firstByte & 0xf0)>>4);
        AudioRate audioRate = (AudioRate)((firstByte & 0x0c)>>2);
        AudioSize audioSize = (AudioSize)((firstByte & 0x02)>>1);
        AudioType audioType = (AudioType)(firstByte & 0x01);
        
        //LOG("AudioDecoderFactory::isSameDecoder: firstByte=0x%x, codecType=%d, audioRate=%d, audioSize=%d, audioType=%d\r\n", firstByte, codecType, audioRate, audioSize, audioType);
        //LOG("AudioDecoderFactory::value, codecType=%d, audioRate=%d, audioSize=%d, audioType=%d\r\n", origSetting->acid, origSetting->ar,origSetting->as, origSetting->at);
            
        //flash speex is always same settings
        if( codecType == kSpeex && origSetting->acid == kSpeex) {
            return true;
        } else {
            return ( codecType == origSetting->acid &&
                     audioRate == origSetting->ar &&
                     audioSize == origSetting->as &&
                     audioType == origSetting->at);
        }
    }
    return false;
}
