#include "InputArray.h"
#include "InputObject.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Output.h"

InputArray::InputArray() {
}
bool InputArray::isEmpty() {    
    OUTPUT("--------isEmpty");
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
    free(obj->data);
    free(obj);
    inputObjectList_.pop_back();
}
unsigned char* InputArray::getTail(unsigned int* len){
    Guard g(&mutex_);
    OUTPUT("-----0----\r\n");
    InputObject* obj = inputObjectList_.back();
    unsigned char* result = NULL;
    if( obj ) {
        OUTPUT("-----1----\r\n");
        result = obj->data;
        *len = obj->len;
        OUTPUT("-----Popped from Inputarray, len=%d----\r\n", *len);
    }
    return result;
}
