#ifndef _INPUT_ARRAY_
#define _INPUT_ARRAY_

#include <iostream>
#include <list>
#include "InputObject.h"

class InputArray
{
public:
    InputArray();
    ~InputArray();
    void pushFront(unsigned char* data, unsigned int len);
    unsigned char* popTail(unsigned int* len);
private:
    std::list<InputObject*> inputObjectList_;
};
#endif

