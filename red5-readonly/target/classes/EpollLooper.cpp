#include "EpollLooper.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include <assert.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <netinet/in.h>
#include <sys/epoll.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/fcntl.h>
#include <sys/wait.h>
#include <sys/prctl.h>
#include <sys/signal.h>
#include <sys/types.h>
#include "Output.h"
#include "InputArray.h"

#define MAXPIPES 100*2
#define MAXEVENTS 100
#define MAX_CLOG_WRITE_BUFFER 5<<20 //5M total it's clogged

void setNonBlocking( int fd )
{
    if ( -1 == fd ) return;
    int a = fcntl( fd, F_GETFL );
    if ( a < 0 ) { perror("fcntl() failed" ); }
    a = fcntl( fd, F_SETFL, a | O_NONBLOCK );
    if ( a < 0 ) { perror("fcntl() failed" ); }
}
//see example from http://byteandbits.blogspot.com/2013/08/tcp-echo-server-using-epoll-example-for.html
void modifyEpollContext(int epollfd, int operation, int fd, uint32_t events, void* data)
{
    struct epoll_event epoll_event;

    epoll_event.events = events;
    epoll_event.data.ptr = data;

    if(-1 == epoll_ctl(epollfd, operation, fd, &epoll_event)) {
        OUTPUT( "Failed to trigger an event for fd=%d events=%d, operation=%d, Error:%s", fd, events, operation, strerror(errno));
    } else {
        OUTPUT( "Success in triggering an event for fd=%d, operation=%d, events=%d", fd, operation, events);
    }
}

EpollLooper::EpollLooper(WriteCallback callback):writeCallback_(callback), totalBytesToWrite_(0)
{
    //Create epoll context.
    epollfd_ = epoll_create(MAXPIPES);
    if(-1 == epollfd_) {
        OUTPUT( "Failed to create epoll context.%s", strerror(errno));
        //exit(1);
    }

    //Start pthread
    bRunning_ = true;
    if(pthread_create(&epollThread_, NULL, &thisThread, (void*)this)) {
        OUTPUT( "Error creating thread\n");
        //exit(1);
    }
    OUTPUT("EpollLooper created, epollFd=%d", epollfd_);
}

EpollLooper::~EpollLooper()
{    
    bRunning_ = false;
    //wait until the looper stops
    if(pthread_join(epollThread_, NULL)) {
        OUTPUT( "Error joining thread\n");
        exit(1);
    }

    //Unregsiter all processes
    std::tr1::unordered_map< int, EpollEvent* >::const_iterator itBegin = procMapping_.begin();
    std::tr1::unordered_map< int, EpollEvent* >::const_iterator itEnd   = procMapping_.end();
    std::tr1::unordered_map< int, EpollEvent* >::const_iterator itTemp;
    while (itBegin != itEnd){
        itTemp = itBegin;          // Keep a reference to the iter
        ++itBegin;                 // Advance in the map
        EpollEvent* event = itTemp->second;
        freeProc(event);
    }
    OUTPUT("EpollLooper destroyed");
}
    
//register process pipe output
void EpollLooper::reg(int procId, int inputToProcess, int outputFromProcess, InputArray* input)
{
    setNonBlocking(inputToProcess);
    //setCloseOnExec(inputToProcess);

    setNonBlocking(outputFromProcess);
    //setCloseOnExec(outputFromProcess);
    
    EpollEvent* epollEvent = (EpollEvent*)calloc(1, sizeof(EpollEvent));
    epollEvent->inputToProcess = inputToProcess;
    epollEvent->outputFromProcess = outputFromProcess;
    epollEvent->input = input;
    epollEvent->procId = procId;
    //add to mapping table
    procMapping_[procId] = epollEvent;
    assert(epollEvent->input);

    //always readt to read output from pipe
    modifyEpollContext(epollfd_, EPOLL_CTL_ADD, epollEvent->outputFromProcess, EPOLLIN, epollEvent);
    OUTPUT("EpollLooper registered, readFd=%d writeFd=%d, procId=%d, ptr=0x%x", inputToProcess, outputFromProcess, procId, epollEvent);
}

void EpollLooper::unreg(int procId)
{
    std::tr1::unordered_map< int, EpollEvent* >::const_iterator got = procMapping_.find( procId );
    if ( got != procMapping_.end() ) {
        EpollEvent* epollEvent = got->second;
        freeProc(epollEvent);
        OUTPUT("EpollLooper unregistered, procId=%d", procId);
    }
}
void EpollLooper::freeProc(EpollEvent* epollEvent)
{
    modifyEpollContext(epollfd_, EPOLL_CTL_DEL, epollEvent->inputToProcess, 0, 0);
    modifyEpollContext(epollfd_, EPOLL_CTL_DEL, epollEvent->outputFromProcess, 0, 0);
    
    close(epollEvent->inputToProcess);
    close(epollEvent->outputFromProcess);
    procMapping_.erase( epollEvent->procId );
    free(epollEvent);
}

//start a thread
void* EpollLooper::thread()
{
    struct epoll_event *events = (struct epoll_event*)calloc(MAXEVENTS, sizeof(struct epoll_event));
    while( bRunning_ ) {
        int n = epoll_wait(epollfd_, events, MAXEVENTS, -1);

        if( -1 == n ) {
            OUTPUT("Failed to wait.%s", strerror(errno));
            exit(1);
        }
        
        for(int i = 0; i < n; i++) {
            /*
             * An event has happend
             */    
            if(events[i].events & EPOLLHUP || events[i].events & EPOLLERR) {
                EpollEvent* epollEvent = (EpollEvent*) events[i].data.ptr;
                OUTPUT("n=%d Pipe broken. %s", n, strerror(errno));
                //broken pipe
                freeProc(epollEvent);
            } else if(EPOLLIN == events[i].events) {
                EpollEvent* epollEvent = (EpollEvent*) events[i].data.ptr;
                //handle read event
                tryToRead(epollEvent);
            } else if(EPOLLOUT == events[i].events) {
                EpollEvent* epollEvent = (EpollEvent*) events[i].data.ptr;
                //delete the write event.
                modifyEpollContext(epollfd_, EPOLL_CTL_DEL, epollEvent->outputFromProcess, 0, 0);
                //handle write event
                if( !tryToWrite(epollEvent) ) {
                    freeProc(epollEvent);
                }
            }
        }
    }
    free(events);
    return NULL;
}

void EpollLooper::tryToRead(EpollEvent* epollEvent)
{
    //output from process pipe
    int n = read(epollEvent->outputFromProcess, epollEvent->readBuffer, MAXLEN);        
    if(0 >= n){
        /*
         * Process Pipe closed 
         */
        OUTPUT("\nPipe closed connection, n=%d.\n", n);
        unreg(epollEvent->procId);
    } else {
        OUTPUT("\nRead data length:%d", n);
        writeCallback_(epollEvent->readBuffer, n, epollEvent->procId); //send it to Java
    }        
}

//notify new data has arrived
void EpollLooper::notifyWrite(int procId, unsigned char* data, int len)
{
    std::tr1::unordered_map< int, EpollEvent* >::const_iterator got = procMapping_.find( procId );
    if ( got != procMapping_.end() ) {
        EpollEvent* epollEvent = got->second;
        totalBytesToWrite_ += len;
        if( len < MAX_CLOG_WRITE_BUFFER ) {
            //register to write
            epollEvent->input->pushFront( data, len ); //push data to the queue
            if(!tryToWrite(epollEvent)) {
                freeProc(epollEvent);
            }
        } else {
            OUTPUT("-----Clogged----\r\n");
            unreg(procId);
        }
    }
}

//tryToWrite
bool EpollLooper::tryToWrite(EpollEvent* epollEvent) {
    bool doneWriting = false;
    bool encounteredError = false;
    InputArray* outgoingBuffers = epollEvent->input;
    assert( outgoingBuffers );

    while (!outgoingBuffers->isEmpty() && !doneWriting) {
        unsigned int len = 0;
        unsigned char* data = outgoingBuffers->getTail(&len);
        unsigned int sent = epollEvent->writeBufOffset;
        assert( sent < len );
        int t = write(epollEvent->inputToProcess, data + sent, len - sent);
        if ( t < 0 ) {
            doneWriting = true;
            int netErrorNumber = errno;
            if ( netErrorNumber == EAGAIN) {
                OUTPUT("-----write again----\r\n");
                //register to write for the next iteration
                modifyEpollContext(epollfd_, EPOLL_CTL_ADD, epollEvent->inputToProcess, EPOLLOUT, epollEvent);
            } else {
                OUTPUT("-----error, netErrorNumber=%d----\r\n", netErrorNumber);
                encounteredError = true;
            }
        } else if ( t == 0 ) {
            doneWriting = true;
            encounteredError = true;
        } else {
            sent += t;
            OUTPUT("-----sent=%d----\r\n", sent);
            if ( sent == len ) {
                outgoingBuffers->popTail();
            } else {
                epollEvent->writeBufOffset = sent;
            }
            totalBytesToWrite_ -= t;
        }
    }

    return (!encounteredError);
}


