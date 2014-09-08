#ifndef __MIXER_CODER_BRIDGE_EXPORT_H__
#define __MIXER_CODER_BRIDGE_EXPORT_H__

#include "InputObject.h"
#define CLASSFUNC(className, funcName)  funcName##_##className

#ifdef __cplusplus
extern "C" 
{
#endif
    //input array related functions
    void* CLASSFUNC(InputArray, create)();
    void CLASSFUNC(InputArray, destroy)(void* object);
    void CLASSFUNC(InputArray, pushFront)(void* object, unsigned char* data, unsigned int len);
    unsigned char* CLASSFUNC(InputArray, popTail)(void* object, unsigned int* len);

    //Epoll Manager
    void* CLASSFUNC(EpollManager, create)(WriteCallback callback, void* input);
    void CLASSFUNC(EpollManager, destroy)(void* object);
    void CLASSFUNC(EpollManager, start)(void* object);
    void CLASSFUNC(EpollManager, stop)(void* object);
#ifdef __cplusplus
}
#endif

#endif
