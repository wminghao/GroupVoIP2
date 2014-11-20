#ifndef __VIDEOTIMESTAMP_MAPPER__
#define __VIDEOTIMESTAMP_MAPPER__

#include "CodecInfo.h"
#include "fwk/log.h"

//video messages comes in FIFO order, original timestamp is mapped directly from FLV timestamp
// However, periodically, audio messages are discarded b/c of slow network or other reasons.
// and audio timestamp will move in a different speed as video. 
// It's possible that video timestamp needs to be adjusted to adapt to the audio timestamp change.
// We clear up video queue to catch up if the queuesize > MAX_VIDEO_QUEUE_SIZE
// When that happens, we adjust the drift_

//video timestamp mapper in case we drop large chunks of video messages
class VideoTimestampMapper
{
 public:
    VideoTimestampMapper() : drift_(0), index_(0) {}
    ~VideoTimestampMapper() {}
    
    void setIndex(u32 index) {
        index_ = index;
    }

    void reset() {
        drift_ = 0;
    }

    void discardFrames( u32 newInsertedTimestamp, u32 firstDiscardedTimestamp ) {
        ASSERT( newInsertedTimestamp > firstDiscardedTimestamp );
        drift_ = (newInsertedTimestamp - firstDiscardedTimestamp);
    }

    u32 getNextTimestamp(u32 ts) {
        ASSERT( ts > drift_ );
        return (ts - drift_);    
    }

 private:
    u32 drift_; //drift apart
    u32 index_; //testing only
};

#endif
