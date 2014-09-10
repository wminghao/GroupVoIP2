#ifndef __PROC_PIPE__
#define __PROC_PIPE__
#include <sys/types.h>

class ProcessPipe
{
 public:
    ProcessPipe();
    ~ProcessPipe();

    int getInFd();
    int getOutFd();
 private:
    void open();
    void close();

 private:
    int p_[2], q_[2];
    pid_t childPid_;
    char **arguments_;
};

#endif
