#!/usr/bin/env bash
ln -s /vagrant/.bash_profile /home/vagrant/.bash_profile
JAVA_VERSION=$(java -version 2>&1 | sed 's/.*version "\(.*\)\.\(.*\)\..*"/\1\2/; 1q')
PATH=.:$PATH

#add repos
add-apt-repository -y ppa:webupd8team/java
#curl -sL https://deb.nodesource.com/setup | sudo bash -
#update
#apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

#deb packages
apt-get install -y vim curl git

echo "Europe/Warsaw" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata






function apache {
apt-get install -y apache2
a2enmod rewrite
}
#mysql

function mysql {
echo "mysql-server-5.5 mysql-server/root_password password $DB_PASSWORD" | sudo debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password_again password $DB_PASSWORD" | sudo debconf-set-selections 
apt-get install -y mysql-server-5.5
}
#samba
function samba {
apt-get install -y samba
}
#cifs
function cifs {
apt-get install -y cifs-utils
}
#php
function php {
apt-get install -y php5 php5-curl php5-xdebug 
echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/app-password-confirm password $DB_PASSWORD' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password $DB_PASSWORD' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password $DB_PASSWORD' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections
apt-get install -y phpmyadmin
}
#java8
function java8 {
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
apt-get install -y oracle-java8-installer
apt-get install -y oracle-java8-set-default
}
#vagrant specific
function vagrant {
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi
}
#nodejs (required by phpdev & javadev)
function nodejs {
#apt-get purge nodejs npm
apt-get install -y nodejs
apt-get install -y npm
npm config set registry http://registry.npmjs.org/
}
#javadev
function javadevtools {
sudo apt-get install -y maven
ln -s /vagrant/settings.xml /home/vagrant/.m2/settings.xml
}
#glassfish
function glassfish {
echo "glassfish download...."
cd /opt
wget -q http://dlc.sun.com.edgesuite.net/glassfish/4.1/release/glassfish-4.1.zip
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
#mysql
#samba
#cifs
#apache
#php
#java8
#nodejs
#phpdevtools
#javadevtools
#eclipsejee
#docker
#vagrant
#glassfish
