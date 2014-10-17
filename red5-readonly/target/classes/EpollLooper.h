#ifndef __EPOLL_PIPE__
#define __EPOLL_PIPE__

#include <tr1/unordered_map>
#include <pthread.h>
#include "InputObject.h"
#include "Guard.h"

#define EFFICIENT_EPOLL

//max instances of 16 mixers per machine, each mixer on average of 4 instances
#define MAXEVENTS 16
#define MAXPIPES MAXEVENTS*2

//each read mx len 100k bytes
#define MAXLEN 100*1024

class InputArray;

typedef struct {
    int inputToProcess;  //write to the pipe
    int outputFromProcess; //read from the pipe

    int procId; //unique identifier
    InputArray* input;

    //temp read buffer
    unsigned char readBuffer[MAXLEN];

    //write buffer offset
    int writeBufOffset;
    
    //indiate closedDue2Error
    bool closedDue2Error;
}EpollEvent;

class EpollLooper
{
 public:
    EpollLooper(WriteCallback callback);
    ~EpollLooper();
    
    //register process pipe input and output
    //TODO return value to java layer
    bool reg(int procId, int inputToProcess, int outputFromProcess, InputArray* input);
    void unreg(int procId);
    
    //notify new data has arrived
    void notifyWrite(int procId, unsigned char* data, int len);

 private:
    //start a thread
    static void* thisThread(void* looper) {
        return ((EpollLooper*)looper)->thread();
    }
    void* thread();

    //try to read from proc pipe
    bool tryToRead(EpollEvent* epollEvent);

    //tryToWrite to proc pipe
    bool tryToWrite(EpollEvent* epollEvent);

    //freeProc
    void freeProc(EpollEvent* epollEvent);
    void closeFd(EpollEvent* epollEvent);
    void closeFd(int fd);
    void closeDueToError(EpollEvent* epollEvent);
 private:
    WriteCallback writeCallback_;
    
    int epollfd_;

    //thread
    pthread_t epollThread_;
    bool bRunning_;

    //mapping table of epollEvent and procId
    std::tr1::unordered_map<int, EpollEvent*> procMapping_;

#ifdef EFFICIENT_EPOLL
    //mutex, per pipe, index starts from 1
    GMutex mutex_[MAXEVENTS+1];
    bool bIsWriterFdEnabled_[MAXEVENTS+1];
#endif
};


#endif
