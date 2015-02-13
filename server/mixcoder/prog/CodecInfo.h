#ifndef __CODECINFOCOMMON_H__
#define __CODECINFOCOMMON_H__

const u32 MAX_LATE_AUDIO_FRAME_THRESHOLD = 10; //150ms max delay to drop/speed up playback //for iOS_air, at least 10 = 260+ms max delay to drop frames
const u32 MIN_LATE_AUDIO_FRAME_THRESHOLD = 5; //78ms max delay to pad with prev frame.   //for iOS_AIr, at least 5 = 130ms max delay

const u32 TIMESTAMP_JUMP_THRESHOLD = 100;
const u32 OUTPUT_VIDEO_FRAME_RATE = 30;
const u32 MAX_XCODING_INSTANCES = 32;
const double videoFrameIntervalInMs = (double)1000 /(double)OUTPUT_VIDEO_FRAME_RATE;

//each speex frame, contains 320 samples
#define SPEEX_FRAME_SAMPLE_SIZE 320

//each mp3 frame, contains 1152 samples
#define MP3_FRAME_SAMPLE_SIZE 1152
#define MP3_SAMPLE_PER_SEC 44100
const double MP3_FRAME_INTERVAL_IN_MS = ((double)1000 * (double)MP3_FRAME_SAMPLE_SIZE)/(double)MP3_SAMPLE_PER_SEC;
const u64 MP3_FRAME_MAX_GAP_IN_MS = ((u64)MP3_FRAME_INTERVAL_IN_MS * 3)/2;

//each aac frame, contains 1024 samples
#define AAC_FRAME_SAMPLE_SIZE 1024
#define AAC_SAMPLE_PER_SEC 44100
const double AAC_FRAME_INTERVAL_IN_MS = ((double)1000 * (double)AAC_FRAME_SAMPLE_SIZE)/(double)AAC_SAMPLE_PER_SEC;
const u64 AAC_FRAME_MAX_GAP_IN_MS = ((u64)AAC_FRAME_INTERVAL_IN_MS * 3)/2;

//Force AAC encoding for all-in-one stream
//#define FORCE_AAC_ALL_IN_ONE

typedef  enum VideoLayout {
    kEvenLayout, //evenly distribute streams across the screen
    kMainLayout //main window + many small window layout
}VideoLayout;

enum specialProperty {
    kRawData, //nalu
    kSpsPps, //avc header
    kEndSeq, //avc end of sequence
    kSeqHeader, //aac header
};

typedef enum StreamSource {
    kUnknownStreamSource = 0,
    kDesktopStreamSource = 1, //desktop don't need a seperate audio mixing
    kMobileStreamSource = 2, //mobile needs a seperate audio mixing for each mobile stream
    kTotalStreamSource
}StreamSource;

typedef enum StreamType {
    kUnknownStreamType = 0,
    kAudioStreamType = 8,
    kVideoStreamType = 9,
    kDataStreamType = 18
}StreamType;

//video types
typedef enum
{
    kKeyFrame,
    kInterFrame,
    kDisposableFrame,
    kGenKeyFrame,
    kVideoInfoFrame
}VideoFrameType;

typedef enum 
{
    kJpegVideopacket = 1,
    kH263VideoPacket = 2,
    kScreenVideoPacket = 3,
    kVP6VideoPacket = 4,
    kVP6AlphaVideoPacket = 5,
    kScreenV2VideoPacket = 6,
    kAVCVideoPacket = 7,
    kVP8VideoPacket = 8
}VideoCodecId;

typedef enum
{
    kAVCSeqHeader,
    kAVCNalu,
    kAVCEndOfSeq
}AVCPacketType;

//audio types
typedef enum
{
    kLinearPCM = 0,
    kADPCM = 1,
    kMP3 = 2,
    kLinearPCMLittleEndian = 3,// little endian
    kNellymoser16 = 4,// 16-kHz mono
    kNellymoser8 = 5, // 8-kHz mono
    kNellymoser = 6,
    kG711ALaw = 7,// A-law logarithmic PCM
    kG711muLaw= 8,// mu-law logarithmic PCM
    kreserved = 9,
    kAAC = 10,
    kSpeex = 11,
    kMP38kHz = 14,
    kMP316kHz = 15,
    kDeviceSpecific = 15 //Device-specific sound, now it's 16khz mp3
}AudioCodecId;

typedef enum
{
    //first 4 enumeration is saved in the flv file
    k5Dot5kHz = 0,
    k11kHz = 1,
    k22kHz = 2,
    k44kHz = 3,
    //next enumeration is not saved in the flv file
    k8kHz = 4,
    k16kHz = 5
}AudioRate;

inline int getFreq(AudioRate ar) {
    int freq = 0;
    switch(ar) {
    case k5Dot5kHz: {
        freq = 5512;
        break;
    }
    case k11kHz: {
        freq = 11025;
        break;
    }
    case k22kHz: {
        freq = 22050;
        break;
    }
    case k44kHz: {
        freq = 44100;
        break;
    }
    case k8kHz: {
        freq = 8000;
        break;
    }
    case k16kHz: {
        freq = 16000;
        break;
    }
    }
    return freq;
}

typedef enum
{
    kSnd8Bit,
    kSnd16Bit
}AudioSize;

typedef enum
{
    kSndMono,
    kSndStereo
}AudioType;

inline int getNumChannels(AudioType at) {
    return (at==kSndMono)?1:2;
}

typedef enum
{
    kAACSeqHeader,
    kAACRaw
}AACPacketType;

typedef struct AudioStreamSetting
{
    AudioCodecId acid;
    AudioRate ar;
    AudioType at;
    AudioSize as;
    int ap; //aac or something else, audio property
    StreamSource ss; //mobile or desktop
    bool bIsValid;// 0 means it's not a valid stream
}AudioStreamSetting;

typedef struct VideoStreamSetting
{
    VideoCodecId vcid;
    //always yv12 format, y plane + u plane + v plane in one buffer
    int width;
    int height;
    StreamSource ss; //mobile or desktop
    bool bIsValid;// 0 means it's not a valid stream
}VideoStreamSetting;

typedef struct VideoRect
{
    int x;
    int y;
    int width;
    int height;
}VideoRect;

inline AudioRate getAudioRate(int frequency) {
    if ( frequency == 5500) {
        return k5Dot5kHz;
    } else if ( frequency == 11025) {
        return k11kHz;
    } else if ( frequency == 22050) {
        return k22kHz;
    } else if ( frequency == 44100) {
        return k44kHz;
    } else if ( frequency == 8000) {
        return k8kHz;
    } else if ( frequency == 16000) {
        return k16kHz;
    } else {
        return k5Dot5kHz;
    }
}

inline bool isVideoRectSame( VideoRect* rect1, VideoRect* rect2 ) {
    return ( rect1->x == rect2->x &&
             rect1->y == rect2->y &&
             rect1->width == rect2->width &&
             rect1->height == rect2->height );
}
#endif
