#include "EpollLooper.h"

EpollLooper::~EpollLooper()
{
    //wait until the looper stops
}
    
//register process pipe input and output
void EpollLooper::reg(int fdIn, int fdOut)
{
    //starts the looper
}

void EpollLooper::unreg(int fdIn, int fdOut)
{
}

void EpollLooper::close()
{
}

//read from inputArray and send to the pipe
void EpollLooper::readInput(unsigned char* data, unsigned int len)
{
    //TODO
}

//read from process pipe any output and send it to java
void EpollLooper::sendOutput(unsigned char* data, unsigned int len)
{
    writeCallback_(data, len);
}
