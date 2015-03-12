cd ..
mvn -Dmaven.test.skip=true -Dclassifier=bootstrap install 
mvn -e -X -U -Dmaven.test.skip=true -Dmaven.buildNumber.doUpdate=false -Dclassifier=bootstrap package 
cd target
tar xzvf red5-server-1.0.2-RC4-server.tar.gz
sudo cp -r red5-server-1.0.2-RC4 /usr/share/
cd ../external
sudo cp -r lib/ /usr/share/red5-server-1.0.2-RC4/
sudo cp -r red5* /usr/share/red5-server-1.0.2-RC4/conf/
sudo cp -r VisparApp  /usr/share/red5-server-1.0.2-RC4/webapp/
cp -r videofiles/ ~/
cd ..
jni.bat
sudo chmod 700 /etc/init.d/red5
sudo /etc/init.d/red5 restart
