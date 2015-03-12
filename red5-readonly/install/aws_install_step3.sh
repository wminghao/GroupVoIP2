sudo apt-get install curl
sudo apt-get install wget
#./aws_build_deploy_red5.sh
cp -r ../external/videofiles/ ~/
cd ..
./jni.bat
sudo cp red5 /etc/init.d/red5
cd install
sudo chmod 700 /etc/init.d/red5
sudo /etc/init.d/red5 restart
