sudo apt-get install curl
sudo apt-get install wget
#./aws_build_deploy_red5.sh
cd ../external
sudo cp -r lib/ /usr/share/red5-server-1.0.2-RC4/
sudo cp -r red5* /usr/share/red5-server-1.0.2-RC4/conf/
sudo cp -r VisparApp  /usr/share/red5-server-1.0.2-RC4/webapp/
sudo cp -r videofiles /usr/share/red5-server-1.0.2-RC4/
cd ..
./jni.bat
sudo cp red5 /etc/init.d/red5
cd install
sudo chmod 700 /etc/init.d/red5
sudo /etc/init.d/red5 restart
