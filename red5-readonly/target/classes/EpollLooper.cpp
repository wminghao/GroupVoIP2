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
        if( EEXIST != errno ) {
            //if exist, do nothing
            OUTPUT( "Failed to trigger an event for fd=%d events=%d, operation=%d, Error:%s", fd, events, operation, strerror(errno));
        }
    } else {
        //OUTPUT( "Success in triggering an event for fd=%d, operation=%d, events=%d", fd, operation, events);
    }
}

EpollLooper::EpollLooper(WriteCallback callback):writeCallback_(callback)
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
    close( epollfd_ );
    OUTPUT("EpollLooper destroyed");
}
    
//register process pipe output
bool EpollLooper::reg(int procId, int inputToProcess, int outputFromProcess, InputArray* input)
{
    bool bSuccess = true;
    if( procId < (MAXEVENTS+1) ) {
        setNonBlocking(inputToProcess);
        setNonBlocking(outputFromProcess);
        
        EpollEvent* epollEvent = (EpollEvent*)calloc(1, sizeof(EpollEvent));
        epollEvent->inputToProcess = inputToProcess;
        epollEvent->outputFromProcess = outputFromProcess;
        epollEvent->input = input;
        epollEvent->procId = procId;
        epollEvent->closedDue2Error = false;
        //add to mapping table
        procMapping_[procId] = epollEvent;
        assert(epollEvent->input);
        
        //always ready to read output from pipe
        modifyEpollContext(epollfd_, EPOLL_CTL_ADD, epollEvent->outputFromProcess, EPOLLIN, epollEvent);
        //but don't try to write unless there is data
#if !defined(EFFICIENT_EPOLL)
        modifyEpollContext(epollfd_, EPOLL_CTL_ADD, epollEvent->inputToProcess, EPOLLOUT, epollEvent);
#endif
        OUTPUT("EpollLooper registered, readFd=%d writeFd=%d, procId=%d, ptr=0x%x", inputToProcess, outputFromProcess, procId, epollEvent);
    } else {
        bSuccess = false;
        OUTPUT("EpollLooper cannot be registered, readFd=%d writeFd=%d, procId=%d", inputToProcess, outputFromProcess, procId);
    }
    return bSuccess;
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
    OUTPUT("===>freeProc");
    closeFd(epollEvent);

    procMapping_.erase( epollEvent->procId );
    free(epollEvent);
}

void EpollLooper::closeFd(EpollEvent* epollEvent)
{
    closeFd(epollEvent->outputFromProcess);
    closeFd(epollEvent->inputToProcess);
}
void EpollLooper::closeFd(int fd) {
    modifyEpollContext(epollfd_, EPOLL_CTL_DEL, fd, 0, 0);
    close(fd);
    OUTPUT("EpollLooper fd=%d closed", fd);
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
                if( epollEvent ) {
                    if( events[i].events & EPOLLHUP ) {
                        OUTPUT("EPOLLHUP i=%d n=%d Pipe broken. %s", i, n, strerror(errno));
                    } else {
                        OUTPUT("EPOLLERR i=%d n=%d Pipe broken. %s", i, n, strerror(errno));
                        /*
                        int       error = 0;
                        socklen_t errlen = sizeof(error);
                        if (getsockopt(epollEvent->inputToProcess, SOL_SOCKET, SO_ERROR, (void *)&error, &errlen) == 0) {
                            OUTPUT("-->Details: EPOLLERR i=%d n=%d Input pipe broken. %s", i, n, strerror(error));
                        } 
                        error = 0;
                        if (getsockopt(epollEvent->outputFromProcess, SOL_SOCKET, SO_ERROR, (void *)&error, &errlen) == 0) {
                            OUTPUT("-->Details: EPOLLERR i=%d n=%d Output pipe broken. %s", i, n, strerror(error));
                        }
                        */
                    }
                    closeDueToError( epollEvent );
                    events[i].data.ptr = NULL;
                }
            } else if(EPOLLIN == events[i].events) {
                EpollEvent* epollEvent = (EpollEvent*) events[i].data.ptr;
                //handle read event
                if( epollEvent && !tryToRead(epollEvent)) {
                    OUTPUT("i=%d n=%d Read failed. %s", i, n, strerror(errno));
                    closeDueToError( epollEvent );
                    events[i].data.ptr = NULL;
                } 
            } else if(EPOLLOUT == events[i].events) {
                EpollEvent* epollEvent = (EpollEvent*) events[i].data.ptr;
                //handle write event
                if( epollEvent && !tryToWrite(epollEvent) ) {
                    OUTPUT("i=%d n=%d Write failed. %s", i, n, strerror(errno));
                    closeDueToError( epollEvent );
                    events[i].data.ptr = NULL;
                }
            }
        }
    }
    free(events);
    return NULL;
}

void EpollLooper::closeDueToError(EpollEvent* epollEvent)
{
    closeFd( epollEvent );
    epollEvent->closedDue2Error = true;
}

bool EpollLooper::tryToRead(EpollEvent* epollEvent)
{
    bool bIsSuccess = true;
    //output from process pipe
    int n = read(epollEvent->outputFromProcess, epollEvent->readBuffer, MAXLEN);        
    if(0 >= n){
        if( n = 0 ) {
            /*
             * Process Pipe read failed
             */
            OUTPUT("Pipe read failed, close Fd, n=%d.\n", n);
            bIsSuccess = false;
        } else{
            if ( errno == EAGAIN ) {
                //try again
                OUTPUT("-----read again later----\r\n");
            } else {
                OUTPUT("Pipe read failed 2, close Fd, n=%d.\n", n);
                bIsSuccess = false;
            }
        }
    } else {
        //OUTPUT("Read data length:%d", n);
        writeCallback_(epollEvent->readBuffer, n, epollEvent->procId); //send it to Java
    }        
    return bIsSuccess;
}

//notify new data has arrived
void EpollLooper::notifyWrite(int procId, unsigned char* data, int len)
{
    std::tr1::unordered_map< int, EpollEvent* >::const_iterator got = procMapping_.find( procId );
    if ( got != procMapping_.end() ) {
        EpollEvent* epollEvent = got->second;
        //push data to the queue, then write to the process
        if( epollEvent) {
            if( epollEvent->closedDue2Error ) {
                //do nothing, since it's already in error mode
            } else if( !epollEvent->input->pushFront( data, len ) ) {
                OUTPUT("-----Clogged----\r\n");
                closeDueToError(epollEvent);
            } else {
#ifdef EFFICIENT_EPOLL
                //notify epollfd input is ready, use edge based epoll
                modifyEpollContext(epollfd_, EPOLL_CTL_ADD, epollEvent->inputToProcess, EPOLLOUT|EPOLLET, epollEvent);
#endif
            }
        }
    }
}

//Right now both read and write to the pipe happens in the epoll loop thread
//Reaason: calling it entirely from the thread to avoid complicated multithread issues
bool EpollLooper::tryToWrite(EpollEvent* epollEvent) {
    bool doneWriting = false;
    bool encounteredError = false;
    InputArray* outgoingBuffers = epollEvent->input;
    assert( outgoingBuffers );

    int procId = epollEvent->procId;
#ifdef EFFICIENT_EPOLL
    //notify epollfd input is done
    modifyEpollContext(epollfd_, EPOLL_CTL_DEL, epollEvent->inputToProcess, 0, 0);
#endif

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
                OUTPUT("-----write again later----\r\n");
#ifdef EFFICIENT_EPOLL
                //notify epollfd input is ready, use edge based epoll
                modifyEpollContext(epollfd_, EPOLL_CTL_ADD, epollEvent->inputToProcess, EPOLLOUT|EPOLLET, epollEvent);
#endif    
            } else {
                OUTPUT("-----error, netErrorNumber=%d----\r\n", netErrorNumber);
                encounteredError = true;
            }
        } else if ( t == 0 ) {
            doneWriting = true;
            encounteredError = true;
            OUTPUT("-----error, netErrorNumber=%d----\r\n", errno);
        } else {
            sent += t;
            if ( sent == len ) {
                epollEvent->writeBufOffset = 0;
                outgoingBuffers->popTail();
            } else {
                epollEvent->writeBufOffset = sent;
            }
        }
    }
    return (!encounteredError);
}

