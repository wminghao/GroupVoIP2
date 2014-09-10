#include "InputArray.h"
#include "InputObject.h"
#include <stdio.h>
#include <stdlib.h>

bool InputArray::isEmpty() {    
    return inputObjectList_.size()>0;
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
    newObj->data = data; //TODO ptr vs. malloc
    newObj->len = len;
    inputObjectList_.push_front(newObj);
}
void InputArray::popTail() {
    free(inputObjectList_.back());
    inputObjectList_.pop_back();
}
unsigned char* InputArray::getTail(unsigned int* len){
    InputObject* newObj = inputObjectList_.back();
    unsigned char * result = newObj->data;
    *len = newObj->len;
    return result;
}
