#ifndef __FLVPARSERDELEGATE_H__
#define __FLVPARSERDELEGATE_H__

#include "fwk/SmartBuffer.h"
#include "CodecInfo.h"
#include "AccessUnit.h"

class FLVParserDelegate
{
 public:
    virtual u32 getGlobalAudioTimestamp() = 0;
    virtual void onFLVFrameParsed( SmartPtr<AccessUnit> au, int index ) = 0;
};
#endif
