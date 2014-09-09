cd target/classes
javah -jni org.red5.server.mixer.MixCoderBridge
gcc -I/usr/lib/jvm/java-6-openjdk-amd64/include/ -g -O -c org_red5_server_mixer_MixCoderBridge.c
g++ -c MixerCoderBridgeExport.cpp
g++ -c InputArray.cpp
g++ -c EpollManager.cpp
#g++ -c EpollLooper.cpp
g++ -c ProcessPipe.cpp
cd ../..
