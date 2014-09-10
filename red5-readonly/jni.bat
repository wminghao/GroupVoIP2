cd target/classes
javah -jni org.red5.server.mixer.MixCoderBridge
gcc -fPIC -I/usr/lib/jvm/java-6-openjdk-amd64/include/ -g -O -c org_red5_server_mixer_MixCoderBridge.c
g++ -fPIC -c MixerCoderBridgeExport.cpp
g++ -fPIC -c InputArray.cpp
g++ -fPIC -c EpollManager.cpp
g++ -fPIC -c EpollLooper.cpp
g++ -fPIC -c ProcessPipe.cpp
g++ -fPIC -c Guard.cpp
gcc -fPIC -shared -o MixCoderBridge.so org_red5_server_mixer_MixCoderBridge.o MixerCoderBridgeExport.o InputArray.o EpollManager.o EpollLooper.o ProcessPipe.o Guard.o
g++ -o dummy dummy.cpp
sudo mv dummy /usr/bin/
rm *.o
cd ../..
