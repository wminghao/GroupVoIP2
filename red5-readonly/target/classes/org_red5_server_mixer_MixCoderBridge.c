#include <stdio.h>
#include <stdlib.h>
#include "org_red5_server_mixer_MixCoderBridge.h"
#include "MixerCoderBridgeExport.h"
#include "Output.h"

// cached refs for later callbacks
JavaVM * g_vm;
jobject g_obj;
jmethodID g_mid;
void* g_epollManager;

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

////////////////////////////////////////////////////////////////////////////
//2nd part, process pipe in a thread. With callback from C code to Java code
////////////////////////////////////////////////////////////////////////////
void callback(unsigned char* data, unsigned int len, int procId) {
    JNIEnv * g_env;
    // double check it's all ok
    jint getEnvStat =(jint) (*g_vm)->GetEnv(g_vm, (void **)&g_env, JNI_VERSION_1_6);
    if (getEnvStat == JNI_EDETACHED) {
        OUTPUT( "GetEnv: not attached" );
        if ((*g_vm)->AttachCurrentThread(g_vm, (void **) &g_env, NULL) != 0) {
            OUTPUT( "Failed to attach" );
        }
    } else if (getEnvStat == JNI_OK) {
        //
    } else if (getEnvStat == JNI_EVERSION) {
        OUTPUT( "GetEnv: version not supported" );
    }

    (*g_env)->CallVoidMethod(g_env, g_obj, g_mid, data, len, procId);

    if ((*g_env)->ExceptionCheck(g_env)) {
        (*g_env)->ExceptionDescribe(g_env);
    }

    (*g_vm)->DetachCurrentThread(g_vm);
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

    //Java callback function. newOutput(byte[] bytesRead, int len, int procId)
    g_mid = (*env)->GetMethodID(env, g_clazz, "newOutput", "([BII)V");
    if (g_mid == NULL) {
        OUTPUT("Unable to get method ref");
    }

    //create an epoll manager
    g_epollManager = CLASSFUNC(EpollManager, create)(callback);
}

/*
 * Class:     org_red5_server_mixer_MixCoderBridge
 * Method:    startProc
 * Signature: (I)V
 */
JNIEXPORT void JNICALL Java_org_red5_server_mixer_MixCoderBridge_startProc
(JNIEnv *env, jobject obj, jint procId) {
    CLASSFUNC(EpollManager, startProc)((void*)g_epollManager, procId);
}

/*
 * Class:     org_red5_server_mixer_MixCoderBridge
 * Method:    stopProc
 * Signature: (I)V
 */
JNIEXPORT void JNICALL Java_org_red5_server_mixer_MixCoderBridge_stopProc
(JNIEnv * env, jobject obj, jint procId) {
    CLASSFUNC(EpollManager, stopProc)((void*)g_epollManager, procId);
}

/*
 * Class:     org_red5_server_mixer_MixCoderBridge
 * Method:    newInput
 * Signature: ([BII)V
 * Description: add the buffer to an linked list
 */
JNIEXPORT void JNICALL Java_org_red5_server_mixer_MixCoderBridge_newInput
(JNIEnv * env, jobject obj, jbyteArray iByteArray, jint len, jint procId) {
    
    jboolean isCopy = JNI_FALSE;
    jbyte* data = (*env)->GetByteArrayElements(env, iByteArray, &isCopy);
    
    CLASSFUNC(EpollManager, newInput)((void*)g_epollManager, procId, data, len);
    (*env)->ReleaseByteArrayElements(env, iByteArray, data, 0);
}


