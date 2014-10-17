#include "EpollManager.h"
#include "ProcessPipe.h"
#include "InputArray.h"
#include "Output.h"
#include <sys/param.h>
#include <sys/fcntl.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/signal.h>
#include <execinfo.h>
#include <sys/types.h>
#include <sys/resource.h>
#include <stdio.h>
#include <string.h>

//TODO the following logic crashes java, b/c syscall is triggered from main java thread, which triggeres the following message:
/*
  Failed to wait.Interrupted system call
  MixCoderBridge exiting.
 */
void my_sigchld_handler(int sig)
{
    pid_t pid;
    int status;

    while ((pid=waitpid(-1, &status, WNOHANG)) != -1) {
        /* Handle the death of pid p */
        OUTPUT("===========child pid=%d died\n", pid);
        // TODO restart the process to continue
    }
}

EpollManager::EpollManager(WriteCallback callback):looper_(callback) {
    signal(SIGCHLD, SIG_IGN); //ignore child process death for now. don't occupy resource in the system
    /* It's better to use sigaction() over signal().  You won't run into the
     * issue where BSD signal() acts one way and Linux or SysV acts another. */
    /*
    struct sigaction sa;

    memset(&sa, 0, sizeof(sa));
    sa.sa_handler = my_sigchld_handler;

    sigaction(SIGCHLD, &sa, NULL);
    */
}
EpollManager::~EpollManager() {
    OUTPUT("--->~EpollManager destroyed");
    std::tr1::unordered_map< int, ProcessObject* >::const_iterator itBegin = pipeMap_.begin();
    std::tr1::unordered_map< int, ProcessObject* >::const_iterator itEnd   = pipeMap_.end();
    std::tr1::unordered_map< int, ProcessObject* >::const_iterator itTemp;

    while (itBegin != itEnd){
        itTemp = itBegin;          // Keep a reference to the iter
        ++itBegin;                 // Advance in the map
        ProcessObject* po = itTemp->second;
        delete( po );
        pipeMap_.erase(itTemp);    // Erase it !!!
    }
}

bool EpollManager::startProc( int procId ) {
    OUTPUT("--->StartProc, id=%d", procId);
    ProcessObject* po = new ProcessObject(); 
    pipeMap_[ procId ] = po;
    return looper_.reg(procId, po->pipe.getInFd(), po->pipe.getOutFd(), &po->input);
}
    
void EpollManager::stopProc( int procId )  {
    OUTPUT("--->StopProc, id=%d", procId);
    std::tr1::unordered_map< int, ProcessObject* >::const_iterator got = pipeMap_.find( procId );
    ProcessObject* object = NULL;
    if ( got != pipeMap_.end() ) {
        object = got->second;
    }
    if ( object != NULL) {
        looper_.unreg(procId);
        delete(object);
        pipeMap_.erase(got);    // Erase it !!!
    }
}

void EpollManager::newInput(int procId, unsigned char* data, unsigned int len)
{
    std::tr1::unordered_map< int, ProcessObject* >::const_iterator got = pipeMap_.find( procId );
    ProcessObject* object = NULL;
    if ( got != pipeMap_.end() ) {
        object = got->second;
    }

    if ( object != NULL) {
        //OUTPUT("-------procId=%d, newInput, len=%d, notify object", procId, len);
        looper_.notifyWrite(procId, data, len); //tell looper there is data now to write
    }
}
