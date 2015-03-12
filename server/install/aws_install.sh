sudo apt-get update
sudo apt-get install subversion scons make fakeroot lintian g++ x264 libx264-dev libswscale-dev
sudo apt-get install libspeex-dev libvpx-dev libx264-dev libmp3lame-dev libavcodec-dev libav-tools libavformat-dev libsamplerate0-dev libmad0-dev libid3tag0-dev 
wget http://downloads.sourceforge.net/opencore-amr/fdk-aac-0.1.3.tar.gz
tar xzvf fdk-aac-0.1.3.tar.gz
cd fdk-aac-0.1.3
./configure --prefix=/usr --disable-static && make && sudo make install

