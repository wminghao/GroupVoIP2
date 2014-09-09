#ifndef _INPUT_OBJECT_
#define _INPUT_OBJECT_

typedef struct {
    unsigned char* data;
    unsigned int len;
}InputObject;

typedef void (*WriteCallback)(unsigned char*, unsigned int, int);

#endif
