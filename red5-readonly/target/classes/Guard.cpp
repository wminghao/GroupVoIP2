#include "Guard.h"

GMutex::GMutex()
{
    pthread_mutexattr_init(&pthread_mutexattr_);  
    pthread_mutexattr_settype(&pthread_mutexattr_, PTHREAD_MUTEX_RECURSIVE);
    pthread_mutex_init(&pthread_mutex_, &pthread_mutexattr_);  
}

GMutex::~GMutex()
{
    pthread_mutexattr_destroy(&pthread_mutexattr_);
    pthread_mutex_destroy(&pthread_mutex_);
}

void GMutex::lock()
{
    pthread_mutex_lock(&pthread_mutex_);
}

void GMutex::unlock()
{
    pthread_mutex_unlock(&pthread_mutex_);
}
