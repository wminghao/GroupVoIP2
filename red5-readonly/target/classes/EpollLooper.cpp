#include "EpollLooper.h"
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <string.h>
#include <errno.h>
#include <netinet/in.h>
#include <stdlib.h>
#include <sys/epoll.h>
#include <unistd.h>
#include <fcntl.h>
#include "Output.h"

#define MAXPIPES 100*2
#define MAXEVENTS 100

void modifyEpollContext(int epollfd, int operation, int fd, uint32_t events, void* data)
{
    struct epoll_event epoll_event;

    epoll_event.events = events;
    epoll_event.data.ptr = data;

    if(-1 == epoll_ctl(epollfd, operation, fd, &epoll_event)) {
        OUTPUT( "Failed to add an event for socket%d Error:%s", fd, strerror(errno));
        exit(1);        
    }
}

EpollLooper::EpollLooper(WriteCallback callback, InputArray* input):writeCallback_(callback), inputArray_(input) 
{
    /*
     * Create epoll context.
     */
    epollfd_ = epoll_create(MAXPIPES);
    if(-1 == epollfd_) {
        OUTPUT( "Failed to create epoll context.%s", strerror(errno));
        exit(1);
    }


    /*
     * Start pthread
     */
    bRunning_ = true;
    if(pthread_create(&epollThread_, NULL, &thisThread, (void*)this)) {
        OUTPUT( "Error creating thread\n");
        exit(1);
    }
}

EpollLooper::~EpollLooper()
{    
    bRunning_ = false;
    //TODO wait forever
    //wait until the looper stops
    if(pthread_join(epollThread_, NULL)) {
        OUTPUT( "Error joining thread\n");
        exit(1);
    }
}
    
//register process pipe input and output
void EpollLooper::reg(int fdRead, int fdWrite)
{
    EpollEvent* epollEvent = calloc(1, sizeof(struct EpollEvent));
    epollEvent->fdRead = fdRead;
    epollEvent->fdWrite = fdWrite;
    modifyEpollContext(epollfd_, EPOLL_CTL_ADD, epollEvent->fdRead, EPOLLIN, epollEvent);
}

void EpollLooper::unreg(int fdRead, int fdWrite)
{
    /*
      TODO
    close(epollEvent->fdRead);
    close(epollEvent->fdWrite);
    free(epollEvent);    
    */
}

void EpollLooper::close()
{
}

//read from inputArray and send to the pipe
void EpollLooper::write(unsigned char* data, unsigned int len)
{
    //TODO
}

//read from process pipe any output and send it to java
void EpollLooper::read(unsigned char* data, unsigned int len)
{
    writeCallback_(data, len);
}

//start a thread
void* EpollLooper::thread()
{
    while( bRunning_ ) {
        
    }
    return NULL;
}

void EpollLooper::handle(EpollEvent* epollEvent)
{
    //output from process pipe
    if(EPOLLIN == epollEvent->event) {
        int n = read(epollEvent->fd, epollEvent->buffer, MAXLEN);        
        if(0 >= n){
            /*
             * Process Pipe closed 
             */
            OUTPUT("\nPipe closed connection.\n");
            close(epollEvent->fdRead);
            close(epollEvent->fdWrite);
            free(epollEvent);
        } else {
            OUTPUT("\nRead data length:%d", n);
            read(epollEvent->buffer, n); //send it to Java

            OUTPUT("\nAdding write event.\n");
            /*
             * We have read the data. Add an write event so that we can
             * write data whenever the socket is ready to be written.
             */
            //TODO
            modifyEpollContext(epollfd_, EPOLL_CTL_ADD, epollEvent->fdRead, EPOLLOUT, epollEvent);
        }        
    } else if(EPOLLOUT == event) {
        //input proess pipe
        int ret;
        ret = write(epollEvent->fdWrite,  epollEvent->buffer + epollEvent->offset, epollEvent->length);
        
        if( (-1 == ret && EINTR == errno) || ret < readLen) {
            /*
             * We either got EINTR or write only sent partial data.
             * Add an write event. We still need to write data.
             */            
            modifyEpollContext(epollfd_, EPOLL_CTL_ADD, epollEvent->fdWrite, EPOLLOUT, epollEvent);
            
            if(-1 != ret) {
                /*
                 * The previous write wrote only partial data to the socket.
                 */
                epollEvent->length -= ret;
                epollEvent->offset += ret;
            }
            
        } else if(-1 == ret) {
            /*
             * Some other error occured.
             */
            close(epollEvent->fdRead);
            close(epollEvent->fdWrite);
            free(epollEvent);
        } else {    
            
            /*
             * The entire data was written. Add an read event,
             * to read more data from the socket.
             */
            OUTPUT("\nAdding Read Event.\n");    
            //TODO
            modifyEpollContext(epollfd, EPOLL_CTL_ADD, epollEvent->fdRead, EPOLLIN, echoEvent);
        }
    }
}

