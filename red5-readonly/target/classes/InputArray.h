#ifndef _INPUT_ARRAY_
#define _INPUT_ARRAY_

#include <iostream>
#include <list>
#include "InputObject.h"

//TODO mutext protection
class InputArray
{
public:
    InputArray();
    ~InputArray();
    void pushFront(unsigned char* data, unsigned int len);
    unsigned char* getTail(unsigned int* len);
    void popTail();
    bool isEmpty();
private:
    std::list<InputObject*> inputObjectList_;
};
#endif

