 #ifndef __FLVSEGMENTINPUT_H
#define __FLVSEGMENTINPUT_H

#include "fwk/SmartBuffer.h"
#include "fwk/Time.h"
#include "FLVParser.h"
#include "CodecInfo.h"
#include "FLVSegmentParserDelegate.h"
#include "RawData.h"
#include "VideoDecoder.h"
#include "AudioDecoder.h"
#include "AudioTimestampMapper.h"
#include <queue>

using namespace std;

///////////////////////////////////
//Segment format as follows
// Header:
//  Meta data = 3 bytes //starting with SGI
//  LayoutMode = 1 byte //Even or Main
//  StreamMask = 4 byte //max of 32 streams
// Content * NoOfStreams:
//  streamId = 5 bits
//  streamSource = 3 bits //desktop or mobile
//  special property = 1 byte //Main layout, whether it's main
//  LengthOfStream = 4 bytes
//  StreamData = n bytes
///////////////////////////////////

///////////////////////////////////
//FLVSegmentInput does the following:
// 1) input tells it how many streams available.
// 2) it parses data and put audio/video inside a queue sorted by timestamp
// 3) for audio, there could be 2 cases
//        a) frame drop(a.k.a. timestamp jump), 
//        b) frames comes in at different speed. 
//       After multiple experiments, 2 simple algorithms achieves the best result.
//        a) trim the queue when a max threshold is reached, meaning data comes in a batch mode.
//        b) fill with prev frame if a stream is missing a frame and other streams' queue size reaches a min threshold
// 4) for video, there could be frame drop, if the TARGET framerate is 30 fps, (timestamp diff is no bigger than 33.33 ms)
//        Every 33.33ms, video data pops out as well, whether there is data or not in the queue, (it's possible a stream having more than 1 video data output for a single frame)
//        if there is no data, mixer will reuse the previous frame to mix it, if there is no previous frame(in the beginning), it will fill with blank.
// 5) Clocks, there is a global timestamp, recording the unified clock of elapsed streams.
//        In the beginning, timestamp must be adjusted to be the same as the global timestamp
//          However, since each video stream is independent from each other, it should move its clock on its own.
//        Except for the case, where there is a jump in timestamp, which means the client is skipping data(both audio and video), 
//          When that happens, the stream's timestamp is resynced with the global timestamp.
///////////////////////////////////

class FLVSegmentInput:public FLVSegmentParserDelegate
{
 public:
 FLVSegmentInput(u32 targetVideoFrameRate, AudioStreamSetting* aRawSetting): parsingState_(SEARCHING_SEGHEADER),
        curSegTagSize_(0), curStreamId_(0), curStreamLen_(0), curStreamCnt_(0),
        numStreams_(0), targetVideoFrameRate_(targetVideoFrameRate), globalAudioTimestamp_(0)
        {
            memset(audioStreamStatus_, 0, sizeof(StreamStatus)*MAX_XCODING_INSTANCES);
            memset(videoStreamStatus_, 0, sizeof(StreamStatus)*MAX_XCODING_INSTANCES);
            for(u32 i = 0; i < MAX_XCODING_INSTANCES; i++) {
                parser_[i] = new FLVParser(this, i);
                audioDecoder_[i] = NULL; //initialize it later
                videoDecoder_[i] = NULL;
                audioTsMapper_[i].setIndex(i);
            }
            memcpy( &rawAudioSettings_, aRawSetting, sizeof(AudioStreamSetting) );

            memset(nextAudioTimestamp_, 0, sizeof(u32)*MAX_XCODING_INSTANCES);
            memset(nextVideoTimestamp_, 0, sizeof(u32)*MAX_XCODING_INSTANCES);
            memset(lastBucketTimestamp_, 0, sizeof(double)*MAX_XCODING_INSTANCES);
            memset(hasStarted_, 0, sizeof(u32)* MAX_XCODING_INSTANCES );
        }
    virtual ~FLVSegmentInput() {
        for(u32 i = 0; i < MAX_XCODING_INSTANCES; i++) {
            delete parser_[i];
            delete audioDecoder_[i];
            delete videoDecoder_[i];
        }
    }
    StreamSource getStreamSource(int streamId) { return streamSource[streamId]; }
    
    bool readData(SmartPtr<SmartBuffer> input);

    //detect whether the next stream is ready or not 
    bool isNextVideoStreamReady(u32& minVideoTimestamp);
    bool isNextAudioStreamReady(u32& minAudioTimestamp);

    //check the status of a stream to see if it's online
    bool isStreamOnlineStarted(StreamType streamType, int index);

    bool hasFirstFrameDecoded(int i, bool bIsVideo) { return bIsVideo?videoDecoder_[i]->hasFirstFrameDecoded(nextVideoTimestamp_[i]):audioDecoder_[i]->hasFirstFrameDecoded(); }

    //get next decoded frame
    SmartPtr<AudioRawData> getNextAudioFrame(u32 index); //return at most 1 frame
    SmartPtr<VideoRawData> getNextVideoFrame(u32 index); // can return more than 1 frames

    //helper function
    void calcQueueSize(u32& maxQueueSize, u32&minQueueSize);
    void printQueueSize();

 private:
    bool isNextVideoFrameSpsPps(u32 index, u32& timestamp);

    //inherited from delegate functions
    virtual void onFLVFrameParsed( SmartPtr<AccessUnit> au, int index );
    virtual u32 getGlobalAudioTimestamp() { return globalAudioTimestamp_;}
 private:
    typedef enum StreamStatus
    {
        kStreamOffline,
        kStreamOnlineNotStarted,
        kStreamOnlineStarted
    } StreamStatus;
    
    typedef enum FLVSegmentParsingState
    {
        SEARCHING_SEGHEADER,
        SEARCHING_STREAM_MASK,
        SEARCHING_STREAM_HEADER,
        SEARCHING_STREAM_DATA
    }FLVSegmentParsingState;

    //parsing logic
    FLVSegmentParsingState parsingState_;
    string curBuf_;
    u32 curSegTagSize_;
    u32 curStreamId_;
    u32 curStreamLen_;
    u32 curStreamCnt_;
    FLVParser* parser_[MAX_XCODING_INSTANCES];
    StreamSource streamSource[MAX_XCODING_INSTANCES];
    u32 numStreams_;

    //stores raw audio and video messages
    queue<SmartPtr<AudioRawData> > audioQueue_[MAX_XCODING_INSTANCES];
    StreamStatus audioStreamStatus_[MAX_XCODING_INSTANCES]; //tells whether a queue has benn used or not
    queue<SmartPtr<VideoRawData> > videoQueue_[MAX_XCODING_INSTANCES];
    StreamStatus videoStreamStatus_[MAX_XCODING_INSTANCES]; //tells whether a queue has been used or not

    //video timestamp adjustment. output is always 30fps
    u32 targetVideoFrameRate_;

    /////////////////////////////////////////////////////////////////////////////////////////////
    //b/c each video stream runs on its own rate of playback, 
    //  1) starting timestamp varies 
    //  2) speed of data arriving varies
    //therefore, 
    //  1) each has its own pace of emptying its queue
    /////////////////////////////////////////////////////////////////////////////////////////////
    u32    nextAudioTimestamp_[ MAX_XCODING_INSTANCES ];      //next audio frame timestamp
    u32    nextVideoTimestamp_[ MAX_XCODING_INSTANCES ];      //next video frame timestamp
    double lastBucketTimestamp_[ MAX_XCODING_INSTANCES ];     //last video frame timestamp
    u32    hasStarted_[ MAX_XCODING_INSTANCES ];                 //1st time video stream starts

    /////////////////////////////////////////////////////////////////////////////////////////////
    //However, a video stream can have timestamp jump back and forth. (Mostly jump forward),
    //  In this case, we need a way to re-sync the timestamp to a relatively global timestamp
    //  Therefore, a global audio timestamp used for avsync between different video streams
    /////////////////////////////////////////////////////////////////////////////////////////////
    u32 globalAudioTimestamp_; 

    //immediately decodes any video/audio messages once we receive any data
    AudioDecoder* audioDecoder_[ MAX_XCODING_INSTANCES ];
    VideoDecoder* videoDecoder_[ MAX_XCODING_INSTANCES ];

    //audio settings for decoder's output
    AudioStreamSetting rawAudioSettings_;

    //current audio timestamp, mapping
    AudioTimestampMapper audioTsMapper_[ MAX_XCODING_INSTANCES ];
};
#endif