#ifndef __AUDIOTIMESTAMP_MAPPER__
#define __AUDIOTIMESTAMP_MAPPER__

#include "CodecInfo.h"
#include "AudioResampler.h"
#include "fwk/log.h"

//audio timestamp mapper from #ofsamples to ms
class AudioTimestampMapper
{
 public:
    AudioTimestampMapper() : startingTimestamp_(MAX_U32), cnt_(0), curTimestamp_(MAX_U32), index_(0) {}
    ~AudioTimestampMapper() {}
    
    void setIndex(u32 index) {
        index_ = index;
    }

    void reset() {
        startingTimestamp_ = MAX_U32;
        curTimestamp_ = MAX_U32;
        cnt_ = 0;
    }

    u32 getLastOrigTimestamp() {
        return curTimestamp_;
    }

    u32 getNextTimestamp(u32 ts) {
        if( MAX_U32 == startingTimestamp_ ) {
            startingTimestamp_ = ts;
            cnt_ = 0;
            LOG("-----------Timestamp Init for stream:%d, startingTimestamp_=%.2f\r\n", index_, startingTimestamp_);
        } else {
            //if timestamp has drifted more than 100ms, reset startingTimestamp_ and cnt
            if( ts > ( curTimestamp_ + TIMESTAMP_JUMP_THRESHOLD ) ) {
                LOG("-----------Timestamp JUMP for stream:%d, oldStartingTimestamp_=%.2f, newStartingTimestamp_=%d\r\n", index_, startingTimestamp_, ts);
                startingTimestamp_ = ts;
                cnt_ = 0;
            }
        }
        curTimestamp_ = ts;

        double tsD = startingTimestamp_ + cnt_ * MP3_FRAME_INTERVAL_IN_MS;
        cnt_++;
        return (u32)tsD;    
    }

 private:
    double startingTimestamp_;
    double cnt_;

    u32 curTimestamp_;

    u32 index_; //testing only
};

#endif
