sudo apt-get update
sudo apt-get install subversion
sudo apt-get install maven
wget http://archive.apache.org/dist/maven/binaries/apache-maven-3.0.4-bin.tar.gz
sudo mkdir /usr/local/apache-maven
gunzip apache-maven-3.0.4-bin.tar.gz
tar xvf apache-maven-3.0.4-bin.tar
sudo mv apache-maven-3.0.4 /usr/local/apache-maven/
rm apache-maven-3.0.4-bin.tar
sudo apt-get install openjdk-6-jdk
