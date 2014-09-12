#include "InputArray.h"
#include "InputObject.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Output.h"

InputArray::InputArray() {
}
bool InputArray::isEmpty() {    
    Guard g(&mutex_);
    return inputObjectList_.empty();
}
InputArray::~InputArray(){
    OUTPUT("-----InputArray destroyed----\r\n");
    while( !inputObjectList_.empty() ) {
        InputObject* newObj = inputObjectList_.back();
        free(newObj->data);
        free(newObj);
        inputObjectList_.pop_back();
    }
}
void InputArray::pushFront(unsigned char* data, unsigned int len) {
    OUTPUT("-----Pushed to Inputarray, len=%d----\r\n", len);
    InputObject* newObj = (InputObject*)malloc(sizeof(InputObject));
    newObj->data = (unsigned char*)malloc(len);
    memcpy(newObj->data, data, len);
    newObj->len = len;
    Guard g(&mutex_);
    inputObjectList_.push_front(newObj);
}
void InputArray::popTail() {
    Guard g(&mutex_);
    InputObject* obj = inputObjectList_.back();
    OUTPUT("-----popTail from Inputarray, len=%d----\r\n", obj->len);
    free(obj->data);
    free(obj);
    inputObjectList_.pop_back();
}
unsigned char* InputArray::getTail(unsigned int* len){
    Guard g(&mutex_);
    InputObject* obj = inputObjectList_.back();
    unsigned char* result = NULL;
    if( obj ) {
        result = obj->data;
        *len = obj->len;
        OUTPUT("-----getTail from Inputarray, len=%d, list size=%d----\r\n", *len, inputObjectList_.size());
    }
    return result;
}
