#include "MixerCoderBridgeExport.h"
#include "InputArray.h"
#include "EpollManager.h"
#include "Logger.h"
extern "C"
{
    void* CLASSFUNC(EpollManager, create)(WriteCallback callback)
    {
        return (void*) (new EpollManager(callback));
    }
    void CLASSFUNC(EpollManager, destroy)(void* object)
    {
        delete((EpollManager*)object);
    }
    void CLASSFUNC(EpollManager, startProc)(void* object, int procId)
    {
        ((EpollManager*)object)->startProc(procId);
    }
    void CLASSFUNC(EpollManager, stopProc)(void* object, int procId)
    {
        ((EpollManager*)object)->stopProc(procId);
    }
    void CLASSFUNC(EpollManager, newInput)(void* object, int procId, unsigned char* data, unsigned int len)
    {
        ((EpollManager*)object)->newInput(procId, data, len);
    }
    void CLASSFUNC(Logger, init)()
    {
        Logger::initLog("MixerCoderBridge");
    }
    void CLASSFUNC(Logger, log)(char* str)
    {
        Logger::log(str);
    }
}
