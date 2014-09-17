#ifndef __AUDIOTIMESTAMP_MAPPER__
#define __AUDIOTIMESTAMP_MAPPER__

#include "CodecInfo.h"
#include "AudioResampler.h"
#include "fwk/log.h"

#define MAX_INT 0xffffffff
//audio timestamp mapper from #ofsamples to ms
class AudioTimestampMapper
{
 public:
    AudioTimestampMapper() : startingTimestamp_(MAX_INT), cnt_(0), curTimestamp_(MAX_INT), index_(0) {}
    ~AudioTimestampMapper() {}
    
    void setIndex(u32 index) {
        index_ = index;
    }

    void reset() {
        startingTimestamp_ = MAX_INT;
        curTimestamp_ = MAX_INT;
        cnt_ = 0;
    }

    u32 getNextTimestamp(u32 ts) {
        if( MAX_INT == startingTimestamp_ ) {
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

        double tsD = startingTimestamp_ + (cnt_ * (double)1000 * (double)MP3_FRAME_SAMPLE_SIZE)/(double)MP3_SAMPLE_PER_SEC;
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
