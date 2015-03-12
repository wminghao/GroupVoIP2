cd ..
./build.bat
cd target
tar xzvf red5-server-1.0.2-RC4-server.tar.gz
sudo cp -r red5-server-1.0.2-RC4 /usr/share/
cd ../external
sudo cp -r lib/ /usr/share/red5-server-1.0.2-RC4/
sudo cp -r red5* /usr/share/red5-server-1.0.2-RC4/conf/
sudo cp -r VisparApp  /usr/share/red5-server-1.0.2-RC4/webapp/
cd ../install
