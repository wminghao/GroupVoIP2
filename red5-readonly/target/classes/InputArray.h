#ifndef _INPUT_ARRAY_
#define _INPUT_ARRAY_

#include <iostream>
#include <list>
#include "InputObject.h"
#include "Guard.h"

class InputArray
{
public:
    InputArray();
    ~InputArray();
    bool pushFront(unsigned char* data, unsigned int len);
    unsigned char* getTail(unsigned int* len);
    void popTail();
    bool isEmpty();
private:
    std::list<InputObject*> inputObjectList_;
    GMutex mutex_;

    //stats
    unsigned int totalBytesToWrite_;
};
#endif

