#ifndef __RAWDATA_H__
#define __RAWDATA_H__

#include "CodecInfo.h"
#include "fwk/SmartBuffer.h"
#include "fwk/log.h"

class VideoRawData;
class VideoRawData: public SmartPtrInterface<VideoRawData> {
 public:
    SmartPtr<SmartBuffer> rawVideoPlanes_[3];
    int rawVideoStrides_[3];
    VideoStreamSetting rawVideoSettings_;
    u32 pts; //pts == dts
    int sp; //special properties, for avc, it's either sps/pps or nalu, for aac, it's sequenceheader or nalu, for other codecs, it's raw data
};

class AudioRawData;
class AudioRawData: public SmartPtrInterface<AudioRawData>{
 public:
    SmartPtr<SmartBuffer> rawAudioFrame_;
    bool bIsStereo; //if it's two channels or single channel, used in mixing
    bool bIsValid;
    StreamSource ss; //special flag, mobile or desktop stream
    u32 pts; //pts == dts
};

//combine 2 audio raw data to shrink the audio length
inline SmartPtr<AudioRawData> combineAudioRawData( SmartPtr<AudioRawData> a1, SmartPtr<AudioRawData> a2) {
    SmartPtr<AudioRawData> c = new AudioRawData();
    if ( c ) {
        c->bIsStereo = a1->bIsStereo;
        c->bIsValid = a1->bIsValid;
        c->ss = a1->ss;
        c->pts = a1->pts;
        u32 bufSize = a1->rawAudioFrame_->dataLength();
        c->rawAudioFrame_ = new SmartBuffer(bufSize);
        if( c->rawAudioFrame_ ) {
            if( a1->bIsStereo ) {
                //combine stereo samples
                u32 i = 0;
                short* target = (short*)c->rawAudioFrame_->data();
                short* src = (short*)a1->rawAudioFrame_->data();
                u32 sampleSize = bufSize/(sizeof(short) * 2);
                LOG( "---combine stereo channels a1->pts=%d, a2->pts=%d, sampleSize=%d", a1->pts, a2->pts, sampleSize);
                while( i< sampleSize ) {
                    target[ i++ ] = (short)(((int)(*src) + ((int)(*(src+2))))/2);
                    target[ i++ ] = (short)(((int)(*src+1) + ((int)(*(src+3))))/2);
                    src += 4;
                }
                src = (short*)a2->rawAudioFrame_->data();
                while( i< sampleSize*2 ) {
                    target[ i++ ] = (short)(((int)(*src) + ((int)(*(src+2))))/2);
                    target[ i++ ] = (short)(((int)(*src+1) + ((int)(*(src+3))))/2);
                    src += 4;
                }
            } else {
                //combine 2 samples
                u32 i = 0;
                short* target = (short*)c->rawAudioFrame_->data();
                short* src = (short*)a1->rawAudioFrame_->data();
                u32 sampleSize = bufSize/sizeof(short);
                LOG( "---combine mono channels a1->pts=%d, a2->pts=%d, sampleSize=%d", a1->pts, a2->pts, sampleSize);
                while( i< sampleSize/2 ) {
                    target[ i++ ] = (short)(((int)(*src) + ((int)(*(src+1))))/2);
                    src += 2;
                }
                src = (short*)a2->rawAudioFrame_->data();
                while( i< sampleSize ) {
                    target[ i++ ] = (short)(((int)(*src) + ((int)(*(src+1))))/2);
                    src += 2;
                }
            }
        }
    }
    return c;
}
#endif //__RAWDATA_H__
