#ifndef __EPOLL_PIPE__
#define __EPOLL_PIPE__

#include "InputObject.h"

class InputArray;

class EpollLooper
{
 public:
    EpollLooper(WriteCallback callback, InputArray* input):writeCallback_(callback), inputArray_(input) {}
    ~EpollLooper();
    
    //register process pipe input and output
    void reg(int fdIn, int fdOut);
    void unreg(int fdIn, int fdOut);

    void close();
 
 private:
    //read from inputArray and send to the pipe
    void readInput(unsigned char* data, unsigned int len);

    //read from process pipe any output and send it to java
    void sendOutput(unsigned char* data, unsigned int len);

 private:
    WriteCallback writeCallback_;
    InputArray* inputArray_;
};


#endif
