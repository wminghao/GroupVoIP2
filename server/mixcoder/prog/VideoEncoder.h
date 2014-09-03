#ifndef __VIDEOENCODER_H__
#define __VIDEOENCODER_H__

#include "fwk/SmartBuffer.h"
#include <queue>
#include <stdio.h>
#include "CodecInfo.h"

//video encoder implementation
class VideoEncoder
{
 public:
    VideoEncoder( VideoStreamSetting* setting, int vBaseLayerBitrate ):vBaseLayerBitrate_(vBaseLayerBitrate) { memcpy(&vSetting_, setting, sizeof(VideoStreamSetting)); }
    virtual ~VideoEncoder() {}
    virtual SmartPtr<SmartBuffer> encodeAFrame(SmartPtr<SmartBuffer> input, bool* bIsKeyFrame) = 0;
    virtual SmartPtr<SmartBuffer> genVideoHeader() { return NULL; }

 protected:
    //input settings and output setting are the same
    VideoStreamSetting vSetting_;

    //output bitrate
    int vBaseLayerBitrate_;
};
#endif
