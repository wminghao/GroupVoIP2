#include <stdio.h>
#include <stdlib.h>
#include "org_red5_server_mixer_MixCoderBridge.h"
#include "MixerCoderBridgeExport.h"

// cached refs for later callbacks
JavaVM * g_vm;
jobject g_obj;
jmethodID g_mid;
void* g_epollManager;

JNIEXPORT jint JNI_OnLoad(JavaVM *vm, void *reserved)
{
    CLASSFUNC(Logger, init)( );
    //monstartup("mixer_coder_bridge.so");
    CLASSFUNC(Logger, log)("JNI_OnLoad");

    return JNI_VERSION_1_6;
}

JNIEXPORT void JNI_OnUnload(JavaVM *vm, void *reserved)
{
    //moncleanup();
    CLASSFUNC(Logger, log)("JNI_OnUnload");
}

////////////////////////////////////////////////////////////////////////////
//2nd part, process pipe in a thread. With callback from C code to Java code
////////////////////////////////////////////////////////////////////////////
void callback(unsigned char* data, unsigned int len, int procId) {
    JNIEnv * env;

    // double check it's all ok
    jint getEnvStat =(jint) (*g_vm)->GetEnv(g_vm, (void **)&env, JNI_VERSION_1_6);
    if (getEnvStat == JNI_EDETACHED) {
        //CLASSFUNC(Logger, log)( "GetEnv: not attached" );
        if ((*g_vm)->AttachCurrentThread(g_vm, (void **) &env, NULL) != 0) {
            CLASSFUNC(Logger, log)( "Failed to attach" );
        }
    } else if (getEnvStat == JNI_OK) {
        //
    } else if (getEnvStat == JNI_EVERSION) {
        CLASSFUNC(Logger, log)( "GetEnv: version not supported" );
    }

    //CLASSFUNC(Logger, log)("MixCoderBridge callback");

    //first copy the data to a byte array
    jbyteArray jb=(*env)->NewByteArray(env, len);
    (*env)->SetByteArrayRegion(env, jb, 0, len, (jbyte *)data);

    (*env)->CallVoidMethod(env, g_obj, g_mid, jb, len, procId);

    if ((*env)->ExceptionCheck(env)) {
        (*env)->ExceptionDescribe(env);
    }

    (*env)->DeleteLocalRef(env, jb);

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
    int status = (*env)->GetJavaVM(env, &g_vm);
    if(status != 0) {
        // Fail!
        CLASSFUNC(Logger, log)("Failed to find jvm");
    }

    // convert local to global reference 
    // (local will die after this method call)
    g_obj = (jobject)((*env)->NewGlobalRef(env, obj));

    // save refs for callback
    jclass clazz = (*env)->GetObjectClass(env, g_obj);
    if (clazz == NULL) {
        CLASSFUNC(Logger, log)("Failed to find class");
    }

    //Java callback function. newOutput(byte[] bytesRead, int len, int procId)
    g_mid = (*env)->GetMethodID(env, clazz, "newOutput", "([BII)V");
    if (g_mid == NULL) {
        CLASSFUNC(Logger, log)("Unable to get method ref");
    }

    //create an epoll manager
    g_epollManager = CLASSFUNC(EpollManager, create)(callback);

    CLASSFUNC(Logger, log)("MixCoderBridge opened");
}

/*
 * Class:     org_red5_server_mixer_MixCoderBridge
 * Method:    startProc
 * Signature: (I)Z
 */
JNIEXPORT jboolean JNICALL Java_org_red5_server_mixer_MixCoderBridge_startProc
(JNIEnv *env, jobject obj, jint procId) {
    CLASSFUNC(Logger, log)("MixCoderBridge startProc");
    return CLASSFUNC(EpollManager, startProc)((void*)g_epollManager, procId);
}

/*
 * Class:     org_red5_server_mixer_MixCoderBridge
 * Method:    stopProc
 * Signature: (I)V
 */
JNIEXPORT void JNICALL Java_org_red5_server_mixer_MixCoderBridge_stopProc
(JNIEnv * env, jobject obj, jint procId) {
    CLASSFUNC(Logger, log)("MixCoderBridge stopProc");
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
    //CLASSFUNC(Logger, log)("MixCoderBridge newInput");
    jbyte* data = (*env)->GetByteArrayElements(env, iByteArray, &isCopy);    
    CLASSFUNC(EpollManager, newInput)((void*)g_epollManager, procId, data, len);
    (*env)->ReleaseByteArrayElements(env, iByteArray, data, 0);
}
