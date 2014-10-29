#ifndef __FLVSEGMENTPARSERDELEGATE_H__
#define __FLVSEGMENTPARSERDELEGATE_H__

#include "fwk/SmartBuffer.h"
#include "CodecInfo.h"
#include "AccessUnit.h"

typedef enum StreamStatus {
    kStreamOffline,
    kStreamOnlineNotStarted,
    kStreamOnlineStarted
} StreamStatus;

class FLVSegmentParserDelegate
{
 public:
    //from FLVParserDelegate
    virtual u32 getGlobalAudioTimestamp() = 0;
    virtual void onFLVFrameParsed( SmartPtr<AccessUnit> au, int index ) = 0;

    //segment parser specific
    virtual void onStreamOffline(int index) = 0;
    virtual StreamStatus getVideoStreamStatus(int index) = 0;
    virtual StreamStatus getAudioStreamStatus(int index) = 0;
    virtual void setVideoStreamStatus(StreamStatus status, int index) = 0;
    virtual void setAudioStreamStatus(StreamStatus status, int index) = 0;
};
#endif
