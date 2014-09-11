#ifndef __MIXER_CODER_BRIDGE_EXPORT_H__
#define __MIXER_CODER_BRIDGE_EXPORT_H__

#include "InputObject.h"
#define CLASSFUNC(className, funcName)  funcName##_##className

#ifdef __cplusplus
extern "C" 
{
#endif
    //Epoll Manager
    void* CLASSFUNC(EpollManager, create)(WriteCallback callback);
    void CLASSFUNC(EpollManager, destroy)(void* object);
    void CLASSFUNC(EpollManager, startProc)(void* object, int procId);
    void CLASSFUNC(EpollManager, stopProc)(void* object, int procId);
    void CLASSFUNC(EpollManager, newInput)(void* object, int procId, unsigned char* data, unsigned int len);

    //syslog
    void CLASSFUNC(Logger, init)();
    void CLASSFUNC(Logger, log)(char* str);
    
#ifdef __cplusplus
}
#endif

#endif
