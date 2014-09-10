#include "InputArray.h"
#include "InputObject.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

InputArray::InputArray() {
    mutex_ = new GMutex();
}
bool InputArray::isEmpty() {    
    Guard g(mutex_);
    return inputObjectList_.size()>0;
}
InputArray::~InputArray(){
    while( !inputObjectList_.empty() ) {
        InputObject* newObj = inputObjectList_.back();
        free(newObj->data);
        inputObjectList_.pop_back();
    }
    delete( mutex_);
}
void InputArray::pushFront(unsigned char* data, unsigned int len) {
    InputObject* newObj = (InputObject*)malloc(sizeof(InputObject));
    newObj->data = (unsigned char*)malloc(len);
    memcpy(newObj->data, data, len);
    newObj->len = len;
    Guard g(mutex_);
    inputObjectList_.push_front(newObj);
}
void InputArray::popTail() {
    Guard g(mutex_);
    InputObject* obj = inputObjectList_.back();
    free(obj->data);
    free(obj);
    inputObjectList_.pop_back();
}
unsigned char* InputArray::getTail(unsigned int* len){
    Guard g(mutex_);
    InputObject* obj = inputObjectList_.back();
    unsigned char* result = obj->data;
    *len = obj->len;
    return result;
}
