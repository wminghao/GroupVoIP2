#ifndef __MIXER_CODER_BRIDGE_EXPORT_H__
#define __MIXER_CODER_BRIDGE_EXPORT_H__

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
#ifdef __cplusplus
}
#endif

#endif
