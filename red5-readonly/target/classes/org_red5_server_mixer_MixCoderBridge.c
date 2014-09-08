#include <stdio.h>
#include <stdlib.h>
#include "org_red5_server_mixer_MixCoderBridge.h"
#include "MixerCoderBridgeExport.h"
#include "Output.h"

// cached refs for later callbacks
JavaVM * g_vm;
jobject g_obj;
jmethodID g_mid;
void* g_inputArray;

JNIEXPORT jint JNI_OnLoad(JavaVM *vm, void *reserved)
{
    //monstartup("mixer_coder_bridge.so");
    OUTPUT("JNI_OnLoad");

    return JNI_VERSION_1_6;
}

JNIEXPORT void JNI_OnUnload(JavaVM *vm, void *reserved)
{
    //moncleanup();
    OUTPUT("JNI_OnUnload");
}

//////////////////////////////////////////////////////////////////////
//First part, java code to call c code.
//////////////////////////////////////////////////////////////////////
/*
 * Class:     org_red5_server_mixer_MixCoderBridge
 * Method:    open
 * Signature: ()V
 * Description: register the callback and open a thread to do process pipe.
 */
JNIEXPORT void JNICALL Java_org_red5_server_mixer_MixCoderBridge_open
(JNIEnv * env, jobject obj) {
    // convert local to global reference 
    // (local will die after this method call)
    g_obj = (jobject)((*env)->NewGlobalRef(env, obj));

    // save refs for callback
    jclass g_clazz = (*env)->GetObjectClass(env, g_obj);
    if (g_clazz == NULL) {
        OUTPUT("Failed to find class");
    }

    //Java callback function. newOutput(byte[] bytesRead, int len)
    g_mid = (*env)->GetMethodID(env, g_clazz, "newOutput", "([BI)V");
    if (g_mid == NULL) {
        OUTPUT("Unable to get method ref");
    }

    //create an input array
    g_inputArray = CLASSFUNC(InputArray, create)();

    //TODO, create a thread for process pipe
}

/*
 * Class:     org_red5_server_mixer_MixCoderBridge
 * Method:    close
 * Signature: ()V
 * Description: close a thread
 */
JNIEXPORT void JNICALL Java_org_red5_server_mixer_MixCoderBridge_close
(JNIEnv *env, jobject obj) {
    //TODO
    CLASSFUNC(InputArray, destroy)(g_inputArray);
}

/*
 * Class:     org_red5_server_mixer_MixCoderBridge
 * Method:    newInput
 * Signature: ([BI)V
 * Description: add the buffer to an linked list
 */
JNIEXPORT void JNICALL Java_org_red5_server_mixer_MixCoderBridge_newInput
(JNIEnv * env, jobject obj, jbyteArray iByteArray, jint len) {
    
    jboolean isCopy = JNI_FALSE;
    jbyte* data = (*env)->GetByteArrayElements(env, iByteArray, &isCopy);
    CLASSFUNC(InputArray, pushFront)((void*)g_inputArray, data, len);
    (*env)->ReleaseByteArrayElements(env, iByteArray, data, 0);
}

////////////////////////////////////////////////////////////////////////////
//2nd part, process pipe in a thread. With callback from C code to Java code
////////////////////////////////////////////////////////////////////////////
