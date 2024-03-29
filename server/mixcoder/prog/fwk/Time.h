#ifndef __FWK_UTIL_H__
#define __FWK_UTIL_H__

#include "Units.h"
#include <sys/time.h>
#include <stdio.h>

inline u64 getEpocTime() {
    struct timeval tv;

    gettimeofday(&tv, NULL);    
    unsigned long long millisecondsSinceEpoch =
        (unsigned long long)(tv.tv_sec) * 1000 +
        (unsigned long long)(tv.tv_usec) / 1000;
    
    //LOG( "%llu\n", millisecondsSinceEpoch);
    return (u64)millisecondsSinceEpoch;
}

#endif
