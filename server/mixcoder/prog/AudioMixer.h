#ifndef __AUDIOMIXER_H__
#define __AUDIOMIXER_H__

extern "C" {
#include <libavcodec/avcodec.h>    // required headers
#include <libavformat/avformat.h>
}

#include "fwk/SmartBuffer.h"
#include "CodecInfo.h"
#include "RawData.h"

//speex 16khz mono is used
class AudioMixer
{
 public:
    AudioMixer() {}
    //do the mixing, for now, always mix n streams into 1 stream
    SmartPtr<SmartBuffer> mixStreams(SmartPtr<AudioRawData>* rawData,
                                     int sampleSize,
                                     int totalStreams,
                                     u32 excludeStreamId);

    //combine 2 audio raw data to shrink the audio length
    static SmartPtr<AudioRawData> combineAudioRawData( SmartPtr<AudioRawData> a1, SmartPtr<AudioRawData> a2);

 private:
    void mixOneStreams(SmartPtr<AudioRawData>* rawData, 
                       int oneIndex,
                       short* valShort,
                       int sampleSize);
    void mixTwoStreams(SmartPtr<AudioRawData>* rawData, 
                       int* twoIndex,
                       short* valShort,
                       int sampleSize);

    void mixThreeStreams(SmartPtr<AudioRawData>* rawData,
                       int* threeIndex,
                       short* valShort,
                       int sampleSize);

    void mixFourStreams(SmartPtr<AudioRawData>* rawData,
                       int* fourIndex,
                       short* valShort,
                       int sampleSize);

    void mixFiveStreams(SmartPtr<AudioRawData>* rawData,
                       int* fiveIndex,
                       short* valShort,
                       int sampleSize);

    void mixSixStreams(SmartPtr<AudioRawData>* rawData,
                       int* sixIndex,
                       short* valShort,
                       int sampleSize);

    void mixSevenStreams(SmartPtr<AudioRawData>* rawData,
                       int* sevenIndex,
                       short* valShort,
                       int sampleSize);

    void mixEightStreams(SmartPtr<AudioRawData>* rawData,
                       int* eightIndex,
                       short* valShort,
                       int sampleSize);

    void mixNineStreams(SmartPtr<AudioRawData>* rawData,
                       int* nineIndex,
                       short* valShort,
                       int sampleSize);

    void findIndexes(SmartPtr<AudioRawData>* rawData,
                     u32 excludeStreamId,
                     int* indexArr);

};
#endif
