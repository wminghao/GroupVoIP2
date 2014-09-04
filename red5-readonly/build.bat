export M2_HOME=/usr/local/apache-maven/apache-maven-3.0.4/
export M2=$M2_HOME/bin
export PATH=$M2:$PATH
export MAVEN_OPTS="-Xms256m -Xmx512m"
export JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64
mvn -Dmaven.test.skip=true -Dclassifier=bootstrap install
mvn -e -X -U -Dmaven.test.skip=true -Dmaven.buildNumber.doUpdate=false -Dclassifier=bootstrap package