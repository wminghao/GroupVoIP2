/* DO NOT EDIT THIS FILE - it is machine generated */
#include <jni.h>
/* Header for class org_red5_server_mixer_MixCoderBridge */

#ifndef _Included_org_red5_server_mixer_MixCoderBridge
#define _Included_org_red5_server_mixer_MixCoderBridge
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     org_red5_server_mixer_MixCoderBridge
 * Method:    open
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_org_red5_server_mixer_MixCoderBridge_open
  (JNIEnv *, jobject);

/*
 * Class:     org_red5_server_mixer_MixCoderBridge
 * Method:    startProc
 * Signature: (I)V
 */
JNIEXPORT void JNICALL Java_org_red5_server_mixer_MixCoderBridge_startProc
  (JNIEnv *, jobject, jint);

/*
 * Class:     org_red5_server_mixer_MixCoderBridge
 * Method:    stopProc
 * Signature: (I)V
 */
JNIEXPORT void JNICALL Java_org_red5_server_mixer_MixCoderBridge_stopProc
  (JNIEnv *, jobject, jint);

/*
 * Class:     org_red5_server_mixer_MixCoderBridge
 * Method:    newInput
 * Signature: ([BII)V
 */
JNIEXPORT void JNICALL Java_org_red5_server_mixer_MixCoderBridge_newInput
  (JNIEnv *, jobject, jbyteArray, jint, jint);

#ifdef __cplusplus
}
#endif
#endif