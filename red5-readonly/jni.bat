cd target/classes
javah -jni org.red5.server.mixer.MixCoderBridge
gcc -fPIC -I/usr/lib/jvm/java-6-openjdk-amd64/include/ -g -O -c org_red5_server_mixer_MixCoderBridge.c
g++ -fPIC -c MixerCoderBridgeExport.cpp
g++ -fPIC -c InputArray.cpp
g++ -fPIC -c EpollManager.cpp
g++ -fPIC -c EpollLooper.cpp
g++ -fPIC -c ProcessPipe.cpp
g++ -fPIC -c Guard.cpp
g++ -fPIC -c Logger.cpp
#TODO, -g for debug
gcc -fPIC -pthread -g -shared -o MixCoderBridge.so org_red5_server_mixer_MixCoderBridge.o MixerCoderBridgeExport.o InputArray.o EpollManager.o EpollLooper.o ProcessPipe.o Guard.o Logger.o
sudo cp MixCoderBridge.so /usr/share/red5-server-1.0.2-RC4/
g++ -o dummy dummy.cpp Logger.o
sudo mv dummy /usr/bin/
rm *.o
cd ../..
