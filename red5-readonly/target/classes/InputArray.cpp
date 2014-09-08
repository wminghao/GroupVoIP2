#include "InputArray.h"
#include "InputObject.h"
#include <stdio.h>
#include <stdlib.h>

InputArray::InputArray() {    
}
InputArray::~InputArray(){
    while( !inputObjectList_.empty() ) {
        InputObject* newObj = inputObjectList_.back();
        free(newObj->data);
        inputObjectList_.pop_back();
    }
}
void InputArray::pushFront(unsigned char* data, unsigned int len) {
    InputObject* newObj = (InputObject*)malloc(sizeof(InputObject));
    newObj->data = data;
    newObj->len = len;
    inputObjectList_.push_front(newObj);
}
unsigned char* InputArray::popTail(unsigned int* len){
    InputObject* newObj = inputObjectList_.back();
    *len = newObj->len;
    unsigned char * result = newObj->data;
    inputObjectList_.pop_back();
    return result;
}

