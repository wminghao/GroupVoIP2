#include "FLVSegmentOutput.h"
#include "FLVOutput.h"
#include <stdio.h>
#include "fwk/log.h"

FLVSegmentOutput::FLVSegmentOutput(VideoStreamSetting* videoSetting, AudioStreamSetting* audioSetting) {
    for( u32 i = 0; i < MAX_XCODING_INSTANCES; i++ ) {
        output_[i] = new FLVOutput(videoSetting, audioSetting);
        outputBuffer_[i] = NULL;
    }
#ifdef FORCE_AAC_ALL_IN_ONE
    //all-in-one frame must be AAC encoding
    audioSetting->acid = kAAC;
#endif //FORCE_AAC_ALL_IN_ONE

    output_[MAX_XCODING_INSTANCES] = new FLVOutput(videoSetting, audioSetting);
    outputBuffer_[MAX_XCODING_INSTANCES] = NULL;
}
    
FLVSegmentOutput::~FLVSegmentOutput() {
    for( u32 i = 0; i < MAX_XCODING_INSTANCES+1; i++ ) {
        delete(output_[i]);
    }
}

void FLVSegmentOutput::saveAudioHeader( SmartPtr<SmartBuffer> audioHeader, int i )
{
    output_[i]->saveAudioHeader(audioHeader);
}

void FLVSegmentOutput::saveVideoHeader( SmartPtr<SmartBuffer> videoHeader )
{
    for( u32 i = 0; i < MAX_XCODING_INSTANCES+1; i++ ) {
        output_[i]->saveVideoHeader(videoHeader);
    }
}

bool FLVSegmentOutput::packageVideoFrame(SmartPtr<SmartBuffer> videoPacket, u32 ts, bool bIsKeyFrame, int streamId )
{
    //if it's allinone stream, package the data, otherwise, it's 1 bytes of empty data, meaning it's the same as all-in-one stream.
    SmartPtr<SmartBuffer> result = (MAX_XCODING_INSTANCES == streamId)?output_[streamId]->packageVideoFrame(videoPacket, ts, bIsKeyFrame): new SmartBuffer(1);

    if( outputBuffer_[streamId] ) {
        //if cuepoint data is there
        outputBuffer_[streamId] = combine2SmartBuffers(outputBuffer_[streamId], result);
    } else {
        outputBuffer_[streamId] = result;
    }
    return true;
}

bool FLVSegmentOutput::packageAudioFrame(SmartPtr<SmartBuffer> audioPacket, u32 ts, int streamId)
{
    outputBuffer_[streamId] = output_[streamId]->packageAudioFrame(audioPacket, ts);
    return true;
}

bool FLVSegmentOutput::packageCuePoint( int streamId, VideoRect* videoRect, u32 pts )
{
    outputBuffer_[streamId] = output_[streamId]->packageCuePoint(videoRect, pts);
    return true;
}

SmartPtr<SmartBuffer> FLVSegmentOutput::getOneFrameForAllStreams(bool bIsVideo)
{
    u32 streamMask = 0;
    u32 totalLen = 0;
    int totalStreams = 0;
    for( u32 i = 0; i <= MAX_XCODING_INSTANCES; i++ ) {
        if( outputBuffer_[i] && outputBuffer_[i]->dataLength() ) {
            totalLen += outputBuffer_[i]->dataLength();
            totalStreams++;
            //streamMask excluding the all-in stream
            if( i != MAX_XCODING_INSTANCES ) {
                u32 val = 0x1<<i;
                streamMask |= val;
            }
        } else if (i == MAX_XCODING_INSTANCES && totalStreams > 0) {
            //Must set empty buffer for all-in stream, since the receiver side always assumes 1 more stream if there is any
            totalStreams++;
        }
    }
    SmartPtr<SmartBuffer> result;
    if( totalLen > 0 ) {
        //LOG( "------getOneFrameForAllStreams totalStreams=%d, streamMask=0x%x\r\n", totalStreams, streamMask);
    
        //Headers
        //  Meta data = 3 bytes //starting with SGO //segment output
        //  StreamMask = 4 byte //max of 32 output streams
        //  Special flag = 1 byte //indicate whether it's video or audio
        // Content * (NoOfStreams+1): //MAX_ID is the all-mixed stream, 1-NoOfStreams are for each mobile stream
        //  streamId = 1 byte
        //  LengthOfStream = 4 bytes
        //  StreamData = n bytes
        result = new SmartBuffer(8 + 5*totalStreams + totalLen);
        u8* data = result->data();
        data[0] = 'S';
        data[1] = 'G';
        data[2] = 'O';
        memcpy(data+3, &streamMask, sizeof(streamMask));
        data[7] = bIsVideo;
        int offset = 8;
        
        for( int i = MAX_XCODING_INSTANCES;  i >= 0; i-- ) {
            if( outputBuffer_[i] && outputBuffer_[i]->dataLength() ) {
                u8 streamIdByte = i;
                memcpy(data+offset, &streamIdByte, sizeof(u8));
                offset += sizeof(u8);
                //LOG( "------streamId=%d, dataLen=%ld, bIsVideo=%d\r\n", i, outputBuffer_[i]->dataLength(), bIsVideo);
                int len = outputBuffer_[i]->dataLength();
                memcpy(data+offset, &len, sizeof(u32));
                offset += sizeof(u32);
                memcpy(data+offset, outputBuffer_[i]->data(), outputBuffer_[i]->dataLength());
                offset += outputBuffer_[i]->dataLength();
                outputBuffer_[i] = NULL; //reset outputbuffer
            } else if( i == MAX_XCODING_INSTANCES ){
                //LOG( "------All-in stream streamId=%d\r\n", i);
                //Must set empty buffer for all-in stream, since the receiver side always assumes 1 more stream if there is any
                u8 streamIdByte = i;
                memcpy(data+offset, &streamIdByte, sizeof(u8));
                offset += sizeof(u8);
                int len = 0;
                memcpy(data+offset, &len, sizeof(u32));
                offset += sizeof(u32);
                outputBuffer_[i] = NULL; //reset outputbuffer
            }
        }
    }
    return result;
}

void FLVSegmentOutput::onStreamEnded(int streamId)
{
    output_[streamId]->onStreamEnded();
    outputBuffer_[streamId] = NULL;
}
