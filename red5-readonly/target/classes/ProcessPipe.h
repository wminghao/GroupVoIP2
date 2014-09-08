#ifndef __PROC_PIPE__
#define __PROC_PIPE__

class ProcessPipe
{
 public:
    ProcessPipe();
    ~ProcessPipe();
    int getInFd();
    int getOutFd();
    void close();
 private:
    int inFd_;
    int outFd_;
};

#endif
