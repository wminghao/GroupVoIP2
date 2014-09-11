#ifndef __EPOLL_PIPE__
#define __EPOLL_PIPE__

#include <tr1/unordered_map>
#include <pthread.h>
#include "InputObject.h"

//each read mx len 100k bytes
#define MAXLEN 100*1024

class InputArray;

typedef struct {
    int event;

    int fdRead;  //read from the pipe
    int fdWrite; //write to the pipe

    int procId; //unique identifier
    InputArray* input;

    //temp read buffer
    unsigned char readBuffer[MAXLEN];

    //write buffer offset
    int writeBufOffset;
}EpollEvent;

class EpollLooper
{
 public:
    EpollLooper(WriteCallback callback);
    ~EpollLooper();
    
    //register process pipe input and output
    void reg(int procId, int fdRead, int fdWrite, InputArray* input);
    void unreg(int procId);
    
    //notify new data has arrived
    void notifyWrite(int procId, int len);

 private:
    //start a thread
    static void* thisThread(void* looper) {
        return ((EpollLooper*)looper)->thread();
    }
    void* thread();

    //try to read from proc pipe
    void tryToRead(EpollEvent* epollEvent);

    //tryToWrite to proc pipe
    bool tryToWrite(EpollEvent* epollEvent);

    //freeProc
    void freeProc(EpollEvent* epollEvent);

 private:
    WriteCallback writeCallback_;
    
    int epollfd_;

    //thread
    pthread_t epollThread_;
    bool bRunning_;

    //mapping table of epollEvent and procId
    std::tr1::unordered_map<int, EpollEvent*> procMapping_;

    //stats
    unsigned int totalBytesToWrite_;

    //flag
    bool bWriteEventAdded_;    
};


#endif
