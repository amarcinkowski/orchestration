#!/usr/bin/env bash

CACHE_DIR=/vagrant/cache/wget
#DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
#sudo echo "Europe/Warsaw" > /etc/timezone
#sudo dpkg-reconfigure -f noninteractive tzdata

function java8 {
  sudo add-apt-repository -y ppa:webupd8team/java
  sudo apt-get update
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
  sudo apt-get install -y oracle-java8-installer
  sudo apt-get install -y oracle-java8-set-default
}

function tomcat8 {
  wget -N -P $CACHE_DIR http://mirrors.ibiblio.org/apache/tomcat/tomcat-8/v8.0.21/bin/apache-tomcat-8.0.21.tar.gz
  tar xvzf apache-tomcat-8.0.21.tar.gz
  sudo mv apache-tomcat-8.0.21 /opt/tomcat
  sudo echo '<?xml version="1.0" encoding="UTF-8"?>
	<tomcat-users version="1.0" xmlns="http://tomcat.apache.org/xml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd">
	<user password="mUzumaP2" roles="admin-gui,manager-gui,manager-script" username="admin"/>
	</tomcat-users>' > /opt/tomcat/conf/tomcat-users.xml
  /opt/tomcat/bin/startup.sh
}

function tomee {
  wget -N -P $CACHE_DIR http://ftp.ps.pl/pub/apache/tomee/tomee-1.7.1/apache-tomee-1.7.1-plume.tar.gz
  tar xvzf $CACHE_DIR/apache-tomee-1.7.1-plume.tar.gz
  sudo mv apache-tomee-plume-1.7.1 /opt/tomee
  wget -N -P $CACHE_DIR http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.35.tar.gz
  tar xvzf $CACHE_DIR/mysql-connector-java-5.1.35.tar.gz
  sudo mv mysql-connector-java-5.1.35/mysql-connector-java-5.1.35-bin.jar /opt/tomee/lib
  sudo echo '<?xml version="1.0" encoding="UTF-8"?>
        <tomcat-users version="1.0" xmlns="http://tomcat.apache.org/xml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd">
        <role rolename="tomee-admin" />
        <user username="tomee" password="tomee" roles="tomee-admin" />
        <user password="mUzumaP2" roles="admin-gui,manager-gui,manager-script" username="admin"/>
        </tomcat-users>' > /opt/tomee/conf/tomcat-users.xml
  sudo echo '<?xml version="1.0" encoding="UTF-8"?>
	<tomee>
	<Resource id="jpa" type="DataSource">
	JdbcDriver com.mysql.jdbc.Driver
	JdbcUrl jdbc:mysql://192.168.50.4:3306/hospital?useUnicode=yes&amp;characterEncoding=UTF-8
	UserName root
	Password pass
	JtaManaged false
	</Resource>
	</tomee>' > /opt/tomee/conf/tomee.xml
  #sudo chown root: /opt/tomee/conf/tomee.xml # read-only prevent overwrite
  /opt/tomee/bin/startup.sh
}

function maven {
  sudo echo '<settings>
  <localRepository>/vagrant/cache/mvn_repo</localRepository>
    <servers>
    <server>
    <id>serwer</id>
    <username>admin</username>
    <password>mUzumaP2</password>
    </server>
    </servers>
  </settings>' > /home/vagrant/.m2/settings.xml
  sudo apt-get install -y maven
}

# -----------------------
sudo apt-get install -y vim curl git 
sudo apt-get install -y samba cifs-utils
maven
java8
tomee

#curl -sL https://deb.nodesource.com/setup | sudo bash -
#javadev
function javadevtools {
  sudo apt-get install -y maven
  ln -s /vagrant/settings.xml /home/vagrant/.m2/settings.xml
}

#glassfish
function glassfish {
  echo "glassfish download...."
  cd /opt
  wget -N -P $CACHE_DIR http://dlc.sun.com.edgesuite.net/glassfish/4.1/release/glassfish-4.1.zip
  echo "glassfish unzip..."
  unzip -q glassfish-4.1.zip
  cd /opt/glassfish4/bin
  echo "glassfish start"
  echo "AS_ADMIN_PASSWORD=glassfish" > pwdfile
  ./asadmin delete-domain domain1
  ./asadmin delete-jdbc-connection-pool --cascade=true DerbyPool
  ./asadmin create-domain hospital
  echo "admin;{SSHA256}80e0NeB6XBWXsIPa7pT54D9JZ5DR5hGQV1kN1OAsgJePNXY6Pl0EIw==;asadmin" > /opt/glassfish4/glassfish/domains/hospital/config/admin-keyfile
  ./asadmin start-domain
  ./asadmin --user admin --passwordfile pwdfile enable-secure-admin
  ./asadmin restart-domain
  #./asadmin start-database 
  echo "glassfish started"
}

