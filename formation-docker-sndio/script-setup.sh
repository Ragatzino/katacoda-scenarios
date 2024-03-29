#!/bin/bash
apt update
# install jdk
apt install default-jdk
# install maven
wget https://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /tmp
tar xf /tmp/apache-maven-*.tar.gz -C /opt
ln -s /opt/apache-maven-3.6.3 /opt/maven
echo "export JAVA_HOME=/usr/lib/jvm/default-java \
export M2_HOME=/opt/maven \
export MAVEN_HOME=/opt/maven \
export PATH=${M2_HOME}/bin:${PATH} \
" >> /etc/profile.d/maven.sh
chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh
# install psql
apt-get install curl ca-certificates gnupg -y
curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
apt-get update
apt install postgresql-client-11 -y

