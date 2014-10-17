#ifndef __EPOLL_MANAGER__
#define __EPOLL_MANAGER__

#include "EpollLooper.h"
#include "ProcessPipe.h"
#include "InputArray.h"
#include <list>
#include <tr1/unordered_map>

class ProcessObject 
{
 public:
    ProcessObject(){}
 public:
    ProcessPipe pipe;
    InputArray input;
};

class EpollManager 
{
 public:
    EpollManager(WriteCallback callback);
    ~EpollManager();

    bool startProc(int procId);
    void stopProc(int procId);

    void newInput(int procId, unsigned char* data, unsigned int len);

 private:
    EpollLooper looper_;
    std::tr1::unordered_map< int, ProcessObject*> pipeMap_;
};
#endif
