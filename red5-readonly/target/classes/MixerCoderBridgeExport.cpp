#include "MixerCoderBridgeExport.h"
#include "InputArray.h"
extern "C"
{
    //input array related functions
    void* CLASSFUNC(InputArray, create)()
    {
        return (void*) (new InputArray());
    }
    void CLASSFUNC(InputArray, destroy)(void* object)
    {
        delete((InputArray*)object);
    }
    void CLASSFUNC(InputArray, pushFront)(void* object, unsigned char* data, unsigned int len)
    {
        ((InputArray*)object)->pushFront(data, len);
    }
    unsigned char* CLASSFUNC(InputArray, popTail)(void* object, unsigned int* len)
    {
        return ((InputArray*)object)->popTail(len);
    }
}
