#ifndef __EPOLL_MANAGER__
#define __EPOLL_MANAGER__

#include "EpollLooper.h"
#include "ProcessPipe.h"

class EpollManager 
{
 public:
    EpollManager(WriteCallback callback, InputArray* input):looper_(callback, input) {
    }
    ~EpollManager() {}

    void start() {
        looper_.reg(pipe_.getInFd(), pipe_.getOutFd());
    }
    
    void stop() {
        looper_.unreg(pipe_.getInFd(), pipe_.getOutFd());
        looper_.close();
        pipe_.close();
    }

 private:
    EpollLooper looper_;
    ProcessPipe pipe_;
};
#endif
