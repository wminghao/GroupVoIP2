#include "InputArray.h"
#include "InputObject.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Output.h"

#define MAX_CLOG_WRITE_BUFFER 2<<20 //2M total it's clogged

InputArray::InputArray():totalBytesToWrite_(0) {
}
bool InputArray::isEmpty() {    
    Guard g(&mutex_);
    return inputObjectList_.empty();
}
InputArray::~InputArray(){
    OUTPUT("-----InputArray destroyed----\r\n");
    while( !inputObjectList_.empty() ) {
        InputObject* newObj = inputObjectList_.back();
        if( newObj ) {
            free(newObj->data);
            free(newObj);
        }
        inputObjectList_.pop_back();
    }
}
bool InputArray::pushFront(unsigned char* data, unsigned int len) {
    bool bRet = true;
    OUTPUT("-----Pushed to Inputarray, len=%d, totalBytesToWrite_=%d----\r\n", len, totalBytesToWrite_);
    if( (totalBytesToWrite_ + len ) < MAX_CLOG_WRITE_BUFFER ) {
        InputObject* newObj = (InputObject*)malloc(sizeof(InputObject));
        bool bIsSuccessful = false;
        if( newObj ) {
            newObj->data = (unsigned char*)malloc(len);
            if( newObj->data ) {
                memcpy(newObj->data, data, len);
                newObj->len = len;
                Guard g(&mutex_);
                inputObjectList_.push_front(newObj);
                totalBytesToWrite_ += len;
                bIsSuccessful = true;
            } 
        }
        if( !bIsSuccessful ) {
            OUTPUT("-----malloc failed InputArray totalBytesToWrite_=%d, len=%d\n", totalBytesToWrite_, len);
        }
    } else {
        OUTPUT("-----exceed InputArray size, totalBytesToWrite_=%d, queuesize=%d len=%d\n", totalBytesToWrite_, inputObjectList_.size(), len);
        bRet = false;
    }
    return bRet;
}
void InputArray::popTail() {
    Guard g(&mutex_);
    InputObject* obj = inputObjectList_.back();
    if( obj ) {
        totalBytesToWrite_ -= obj->len;
        //OUTPUT("-----popTail from Inputarray, len=%d----\r\n", obj->len);
        free(obj->data);
        free(obj);
        inputObjectList_.pop_back();
    }
}
unsigned char* InputArray::getTail(unsigned int* len){
    Guard g(&mutex_);
    InputObject* obj = inputObjectList_.back();
    unsigned char* result = NULL;
    if( obj ) {
        result = obj->data;
        *len = obj->len;
        //OUTPUT("-----getTail from Inputarray, len=%d, list size=%d----\r\n", *len, inputObjectList_.size());
    }
    return result;
}
