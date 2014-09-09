#ifndef __EPOLL_PIPE__
#define __EPOLL_PIPE__

#include <pthread.h>
#include "InputObject.h"

//each read mx len 100k bytes
#define MAXLEN 100*1024

class InputArray;
typedef struct {
    int event;

    int fdRead;
    int fdWrite;

    //read/write buffer
    unsigned char buffer[MAXLEN];
    int length;
    int offset;
}EpollEvent;

class EpollLooper
{
 public:
    EpollLooper(WriteCallback callback);
    ~EpollLooper();
    
    //register process pipe input and output
    void reg(int fdRead, int fdWrite, InputArray* input);
    void unreg(int fdRead, int fdWrite);

    void close();
 
 private:
    //read from inputArray and send to the pipe
    void write(unsigned char* data, unsigned int len);

    //read from process pipe any output and send it to java
    void read(unsigned char* data, unsigned int len);

    //start a thread
    static void* thisThread(void* looper) {
        return ((EpollLooper*)looper)->thread();
    }
    void* thread();

    //handles IO
    void handle(EpollEvent* epollEvent);

 private:
    WriteCallback writeCallback_;
    InputArray* inputArray_;
    
    int epollfd_;

    //thread
    pthread_t epollThread_;
    bool bRunning_;
};


#endif
