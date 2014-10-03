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

EpollManager::EpollManager(WriteCallback callback):looper_(callback) {
    //TODO monitor child process status, and restart it if necessary.
    signal(SIGCHLD, SIG_IGN); //ignore child process death for now. don't occupy resource in the system
}
EpollManager::~EpollManager() {
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

void EpollManager::startProc( int procId ) {
    OUTPUT("--->StartProc, id=%d", procId);
    ProcessObject* po = new ProcessObject(); 
    pipeMap_[ procId ] = po;
    looper_.reg(procId, po->pipe.getInFd(), po->pipe.getOutFd(), &po->input);
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
        looper_.notifyWrite(procId, data, len); //tell looper there is data now to write
    }
}
