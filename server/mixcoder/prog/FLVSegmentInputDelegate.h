#ifndef __FLVSEGMENTINPUT_DELEGATE__
#define __FLVSEGMENTINPUT_DELEGATE__

class FLVSegmentInputDelegate
{
 public:
    virtual void onStreamEnded(int streamId) = 0;
};

#endif
