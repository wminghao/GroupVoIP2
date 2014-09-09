#include "EpollManager.h"
#include "ProcessPipe.h"
#include "InputArray.h"

EpollManager::EpollManager(WriteCallback callback):looper_(callback) {
}
EpollManager::~EpollManager() {
    std::tr1::unordered_map< int, ProcessObject* >::const_iterator itBegin = pipeMap_.begin();
    std::tr1::unordered_map< int, ProcessObject* >::const_iterator itEnd   = pipeMap_.end();
    std::tr1::unordered_map< int, ProcessObject* >::const_iterator itTemp;

    while (itBegin != itEnd){
        itTemp = itBegin;          // Keep a reference to the iter
        ++itBegin;                 // Advance in the map
        ProcessObject* po = itTemp->second;
        po->pipe.close();
        delete( po );
        pipeMap_.erase(itTemp);    // Erase it !!!
    }
    looper_.close();
}

void EpollManager::startProc( int procId ) {
    ProcessObject* po = new ProcessObject(); 
    pipeMap_[ procId ] = po;
    looper_.reg(po->pipe.getInFd(), po->pipe.getOutFd(), &po->input);
}
    
void EpollManager::stopProc( int procId ) {
    std::tr1::unordered_map< int, ProcessObject* >::const_iterator got = pipeMap_.find( procId );
    ProcessObject* object = NULL;
    if ( got != pipeMap_.end() ) {
        object = got->second;
    }
    if ( object != NULL) {
        looper_.unreg(object->pipe.getInFd(), object->pipe.getOutFd());
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
        object->input.pushFront( data, len );
    }
}
