#ifndef __SAFE_GUARD__
#define __SAFE_GUARD__

#include <pthread.h>

class GMutex{
 public:
    GMutex();
    ~GMutex();
    void lock();
    void unlock();
 private:
    pthread_mutex_t pthread_mutex_;
    pthread_mutexattr_t pthread_mutexattr_;
    bool bIsRecursiveLock_;
};

class Guard{
 public:
    //TODO mutex has some problem here
    Guard(GMutex* mutex):mutex_(mutex) { /* mutex_->lock(); */}
    ~Guard() { /*mutex_->unlock();*/ }
 private:
    GMutex* mutex_;
};
#endif
