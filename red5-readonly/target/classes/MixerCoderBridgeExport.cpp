#include "MixerCoderBridgeExport.h"
#include "InputArray.h"
#include "EpollManager.h"
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

    void* CLASSFUNC(EpollManager, create)(WriteCallback callback, void* input)
    {
        return (void*) (new EpollManager(callback, (InputArray*)input));
    }
    void CLASSFUNC(EpollManager, destroy)(void* object)
    {
        delete((EpollManager*)object);
    }
    void CLASSFUNC(EpollManager, start)(void* object)
    {
        ((EpollManager*)object)->start();
    }
    void CLASSFUNC(EpollManager, stop)(void* object)
    {
        ((EpollManager*)object)->stop();
    }
}
