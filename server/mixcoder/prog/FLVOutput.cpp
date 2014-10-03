#include "FLVOutput.h"
#include <stdio.h>
#include "fwk/log.h"
#include "FLVScript.h"

//5th byte 0x01 video, 0x04 audio, 0x05 video+audio
const u8 flvHeader[] = {
    0x46,0x4c,0x56,0x01,0x05, //5 bytes flv + type
    0x00,0x00,0x00,0x09, //length = 9
    0x00,0x00,0x00,0x00, //prev len = 0
    0x12,0x00,0x01,0x23,0x00,0x00,0x00,0x00,0x00,0x00,0x00, //11 bytes data tag, len=0x12E-0x0b(11 bytes)
    0x02,
    0x00,0x0a,0x6f,0x6e,0x4d,0x65,0x74,0x61,0x44,0x61,0x74,0x61, //onMetaData
    0x08,0x00,0x00,0x00,0x0d, //array of 13 elements
    0x00,0x08,0x64,0x75,0x72,0x61,0x74,0x69,0x6f,0x6e, //duration
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, //0.00
    0x00,0x0C,0x61,0x75,0x64,0x69,0x6F,0x63,0x6F,0x64,0x65,0x63,0x69,0x64, //audiocodecid
    0x00,0x40,0x00,0x00,0x00,0x00,0x00,0x00,0x00, //speex = 11(0x4026000000000000), 16kmp3 = 15(0x402e000000000000), mp3 = 2(0x4000000000000000)
    0x00,0x0D,0x61,0x75,0x64,0x69,0x6F,0x64,0x61,0x74,0x61,0x72,0x61,0x74,0x65,//audiodatarate
    0x00,0x40,0x3B,0xCC,0xCC,0xCC,0xCC,0xCC,0xCD,
    0x00,0x0F,0x61,0x75,0x64,0x69,0x6F,0x73,0x61,0x6D,0x70,0x6C,0x65,0x72,0x61,0x74,0x65, //audiosamplerate
    0x00,0x40,0xE5,0x88,0x80,0x00,0x00,0x00,0x00, //16k = 0x40CF400000000000, 44.1k = 40e5888000000000
    0x00,0x0F,0x61,0x75,0x64,0x69,0x6F,0x73,0x61,0x6D,0x70,0x6C,0x65,0x73,0x69,0x7A,0x65, //audiosamplesize
    0x00,0x40,0x30,0x00,0x00,0x00,0x00,0x00,0x00, //16bits
    0x00,0x06,0x73,0x74,0x65,0x72,0x65,0x6F, //stereo
    0x01,0x01, //bool, stereo
    0x00,0x0c,0x76,0x69,0x64,0x65,0x6f,0x63,0x6f,0x64,0x65,0x63,0x69,0x64, //videocodecid
    0x00,0x40,0x1c,0x00,0x00,0x00,0x00,0x00,0x00,//0x4020000000000000 stands for codecid=8, vp8, //0x401c000000000000 stands for codecid=7, h264, // 4000000000000000 stands for codecId=2, sorenson
    0x00,0x05,0x77,0x69,0x64,0x74,0x68, //width
    0x00,0x40,0x84,0x00,0x00,0x00,0x00,0x00,0x00,// = 640.00
    0x00,0x06,0x68,0x65,0x69,0x67,0x68,0x74, //height
    0x00,0x40,0x7e,0x00,0x00,0x00,0x00,0x00,0x00, // = 480.00
    0x00,0x09,0x66,0x72,0x61,0x6d,0x65,0x72,0x61,0x74,0x65, //framerate
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,//0
    0x00,0x0d,0x76,0x69,0x64,0x65,0x6f,0x64,0x61,0x74,0x61,0x72,0x61,0x74,0x65, //videodatarate ???
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,//0.00
    0x00,0x07,0x65,0x6e,0x63,0x6f,0x64,0x65,0x72, //encoder
    0x02,0x00,0x0b,0x4c,0x61,0x76,0x66,0x35,0x32,0x2e,0x38,0x37,0x2e,0x31,
    0x00,0x08,0x66,0x69,0x6c,0x65,0x73,0x69,0x7a,0x65, //filesize
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, //0.00
    0x00,0x00,0x09, //ends with 9
    0x00,0x00,0x01,0x2E //previous tag len, len=0x12E
};

const u8 audioSpeexTagByte = 0xbe; //speex
const u8 audioMp316kTagByte = 0xfe; //16khzmp3
const u8 audioMp3TagByte = 0x2f; //44.1khzmp3

const u32 fixedFlvHeaderLen = 11;

SmartPtr<SmartBuffer> FLVOutput::newFlvHeader()
{
    //ignore audioheader since it's speex
    SmartPtr<SmartBuffer> header = new SmartBuffer(sizeof(flvHeader));
    u8* data = header->data();
    u32 offset = 0;

    //first build flvheader
    memcpy( data, flvHeader, sizeof(flvHeader) );
    offset += sizeof(flvHeader);
    
    return header;
}

SmartPtr<SmartBuffer> FLVOutput::newVideoHeader(u32 ts)
{
    //only for h264 videos
    if( videoSetting_.vcid == kAVCVideoPacket ) {
        if( !videoHeaderSent_ ) {
            videoHeaderSent_  = true;
            //build video header
            u32 additionalHeader = 4; 
            u32 videoPacketLen = videoHeader_->dataLength();
            u32 videoDataLen = videoPacketLen + 1 + additionalHeader;
            SmartPtr<SmartBuffer> result = new SmartBuffer( fixedFlvHeaderLen + videoDataLen + 4 );
            u8* data = result->data();
            
            //frame tag
            data[0] = (u8)kVideoStreamType;
            //frame data length
            data[1] = (u8)((videoDataLen>>16)&0xff);
            data[2] = (u8)((videoDataLen>>8)&0xff);
            data[3] = (u8)(videoDataLen&0xff);
            //frame time stamp
            data[4] = (u8)((ts>>16)&0xff);
            data[5] = (u8)((ts>>8)&0xff);
            data[6] = (u8)(ts&0xff);
            //frame time stamp extend
            data[7] = (u8)((ts>>24)&0xff);
            //frame reserved
            data[8] = 0;
            data[9] = 0;
            data[10] = 0;
            
            data[11] = (u8)(0x10 | videoSetting_.vcid);
            
            data[12] = 0x0; //AVC header
            data[13] = 0x0; //composition time offset
            data[14] = 0x0;
            data[15] = 0x0;
            
            if ( videoPacketLen > 0 ) {
                memcpy(&data[fixedFlvHeaderLen+1+additionalHeader], videoHeader_->data(), videoPacketLen);
            }
            //prev tag size
            int tl = fixedFlvHeaderLen + videoDataLen;
            data[tl] = (u8)((tl>>24)&0xff);
            data[tl+1] = (u8)((tl>>16)&0xff);  
            data[tl+2] = (u8)((tl>>8)&0xff);  
            data[tl+3] = (u8)(tl&0xff);  
            
            //LOG("====>video header len=%d, videoDataLen=%d, ts=%d, vcid=0x%x\n", tl, videoDataLen, ts, videoSetting_.vcid);
            return result;
        }    
    } 
    return NULL;
}

SmartPtr<SmartBuffer> FLVOutput::packageCuePoint( VideoRect* videoRect, u32 ts )
{
    // packaging x,y,width,height
    int x = 0;
    int y = 0;
    int width = 0;
    int height = 0;
    if( videoRect ) {
        x = videoRect->x;
        y = videoRect->y;
        width = videoRect->width;
        height = videoRect->height;
    }
    
    //convert to ecma cuepoint array
    FLVScript onCuePoint;
    onCuePoint.newNameValuePair("x", x);
    onCuePoint.newNameValuePair("y", y);
    onCuePoint.newNameValuePair("width", width);
    onCuePoint.newNameValuePair("height", height);
    
    SmartPtr<SmartBuffer> dataPacket = onCuePoint.toBuf("onCuePoint");

    u32 dataPacketLen = dataPacket->dataLength();
    SmartPtr<SmartBuffer> dataFrame = new SmartBuffer( fixedFlvHeaderLen + dataPacketLen + 4 );
    u8* data = dataFrame->data();

    //frame tag
    data[0] = (u8)kDataStreamType;
    //frame data length
    data[1] = (u8)((dataPacketLen>>16)&0xff);
    data[2] = (u8)((dataPacketLen>>8)&0xff);
    data[3] = (u8)(dataPacketLen&0xff);
    //frame time stamp
    data[4] = (u8)((ts>>16)&0xff);
    data[5] = (u8)((ts>>8)&0xff);
    data[6] = (u8)(ts&0xff);
    //frame time stamp extend
    data[7] = (u8)((ts>>24)&0xff);
    //frame reserved
    data[8] = 0;
    data[9] = 0;
    data[10] = 0;

    if ( dataPacketLen > 0 ) {
        memcpy(&data[fixedFlvHeaderLen], dataPacket->data(), dataPacketLen);
    }

    //prev tag size
    int tl = fixedFlvHeaderLen + dataPacketLen;
    data[tl] = (u8)((tl>>24)&0xff);
    data[tl+1] = (u8)((tl>>16)&0xff);
    data[tl+2] = (u8)((tl>>8)&0xff);
    data[tl+3] = (u8)(tl&0xff);

    if( !flvHeaderSent_ ) {
        flvHeaderSent_  = true;
        return combine2SmartBuffers(newFlvHeader(), dataFrame);
    } else {
        return dataFrame;
    }
}

SmartPtr<SmartBuffer> FLVOutput::packageVideoFrame(SmartPtr<SmartBuffer> videoPacket, u32 ts, bool bIsKeyFrame)
{
    //then build video header
    u32 additionalHeader = (videoSetting_.vcid == kAVCVideoPacket)?4:0; //vp8 is 0
    u32 videoPacketLen = videoPacket->dataLength();
    u32 videoDataLen = videoPacketLen + 1 + additionalHeader;
    SmartPtr<SmartBuffer> videoFrame = new SmartBuffer( fixedFlvHeaderLen + videoDataLen + 4 );
    u8* data = videoFrame->data();

    //if it's keyframe, inject spspps for each frame
    if( bIsKeyFrame ) {
        videoHeaderSent_ = false;
    }

    //frame tag
    data[0] = (u8)kVideoStreamType;
    //frame data length
    data[1] = (u8)((videoDataLen>>16)&0xff);
    data[2] = (u8)((videoDataLen>>8)&0xff);
    data[3] = (u8)(videoDataLen&0xff);
    //frame time stamp
    data[4] = (u8)((ts>>16)&0xff);
    data[5] = (u8)((ts>>8)&0xff);
    data[6] = (u8)(ts&0xff);
    //frame time stamp extend
    data[7] = (u8)((ts>>24)&0xff);
    //frame reserved
    data[8] = 0;
    data[9] = 0;
    data[10] = 0;

    if ( bIsKeyFrame) {
        data[11] = (u8)(0x10 | videoSetting_.vcid);
    } else {
        data[11] = (u8)(0x20 | videoSetting_.vcid);
    }

    if( videoSetting_.vcid == kAVCVideoPacket ) {
        data[12] = 0x1; //nalu data
        data[13] = 0x0; //composition time offset
        data[14] = 0x0;
        data[15] = 0x0;
    } 

    if ( videoPacketLen > 0 ) {
        memcpy(&data[fixedFlvHeaderLen+1+additionalHeader], videoPacket->data(), videoPacketLen);
    }
    //prev tag size
    int tl = fixedFlvHeaderLen + videoDataLen;
    data[tl] = (u8)((tl>>24)&0xff);
    data[tl+1] = (u8)((tl>>16)&0xff);  
    data[tl+2] = (u8)((tl>>8)&0xff);  
    data[tl+3] = (u8)(tl&0xff);  

    //LOG("====>video frame len=%d, videoDataLen=%d ts=%d\n", tl, videoDataLen, ts);
    if( videoSetting_.vcid == kAVCVideoPacket ) {
        if( !flvHeaderSent_ ) {
            SmartPtr<SmartBuffer> flvHeader = newFlvHeader();
            u32 totalLen = flvHeader->dataLength() + videoFrame->dataLength();

            SmartPtr<SmartBuffer> h264Header = newVideoHeader( ts );
            if( h264Header ) {
                totalLen += h264Header->dataLength();
            }

            SmartPtr<SmartBuffer> result = new SmartBuffer(totalLen);
            u8* data = result->data();
            memcpy(data, flvHeader->data(), flvHeader->dataLength());
            u32 offset = flvHeader->dataLength();
            if( h264Header ) {
                memcpy(data + offset, h264Header->data(), h264Header->dataLength());
                offset += h264Header->dataLength();
            }
            memcpy(data + offset, videoFrame->data(), videoFrame->dataLength());
            
            flvHeaderSent_  = true;
            return result;
        } else {
            SmartPtr<SmartBuffer> h264Header = newVideoHeader( ts );
            if( h264Header ) {
                return combine2SmartBuffers(h264Header, videoFrame);
            } else {
                return videoFrame;
            }
        }
    } else {         
        if( !flvHeaderSent_ ) {
            flvHeaderSent_  = true;
            return combine2SmartBuffers(newFlvHeader(), videoFrame);
        } else {
            return videoFrame;
        }
    }
}

SmartPtr<SmartBuffer> FLVOutput::packageAudioFrame(SmartPtr<SmartBuffer> audioPacket, u32 ts)
{
    u32 audioDataLen = audioPacket->dataLength()+1;
    SmartPtr<SmartBuffer> audioFrame = new SmartBuffer(fixedFlvHeaderLen + audioDataLen + 4);
    u8* data = audioFrame->data();

    //FLV_TAG_TYPE_AUDIO
    //{
    data[0] = (u8)kAudioStreamType;
    //frame data size
    data[1] = (u8)((audioDataLen>>16)&0xff); 
    data[2] = (u8)((audioDataLen>>8)&0xff);  
    data[3] = (u8)(audioDataLen&0xff); 
    //frame timestatmp

    data[4] = (u8)((ts>>16)&0xff);
    data[5] = (u8)((ts>>8)&0xff);
    data[6] = (u8)(ts&0xff);
    //frame time stamp extend
    data[7] = (u8)((ts>>24)&0xff);

    //StreamID
    data[8] = 0;
    data[9] = 0;
    data[10] = 0;
    //frame data begin
    //{
    //
    if( audioSetting_.acid == kMP316kHz ) {
        data[11] = audioMp316kTagByte;
    } else if( audioSetting_.acid == kMP3 ) {
        data[11] = audioMp3TagByte;
    } else {
        data[11] = audioSpeexTagByte;
    }

    if( audioDataLen > 1 ) {
        memcpy(&data[12], audioPacket->data(), audioPacket->dataLength());
    }
    //prev tag size
    int tl = fixedFlvHeaderLen + audioDataLen;
    data[tl] = (u8)((tl>>24)&0xff);
    data[tl+1] = (u8)((tl>>16)&0xff);  
    data[tl+2] = (u8)((tl>>8)&0xff);    
    data[tl+3] = (u8)(tl&0xff);

    //LOG("====>audio frame len=%d, audioDataLen=%d ts=%d\n", tl, audioDataLen, ts);
    if( !flvHeaderSent_ ) {
        flvHeaderSent_  = true;
        return combine2SmartBuffers(newFlvHeader(), audioFrame);
    } else {
        return audioFrame;
    }
}
