echo "=======================================";
echo "loading bash profile";
# wp wp-cli
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
export DB_NAME=wordpress
export DB_USER=root
export DB_PASSWORD=pass
export DB_URL="jdbc:mysql://localhost:3306/$DB_NAME?useUnicode=yes&amp;characterEncoding=UTF-8"
# composer
export GITHUB_USER=
export GITHUB_OAUTH_TOKEN=
# tomcat
export TOMCATADMINPASSWORD=
export CATALINA_HOME=/opt/tomcat
export CATALINA_OPTS="-Xms=512M -Xmx=1024M"
# wp
export AUTH_KEY=
export SECURE_AUTH_KEY=
export LOGGED_IN_KEY=
export NONCE_KEY=
export AUTH_SALT=
export SECURE_AUTH_SALT=
export LOGGED_IN_SALT=
export NONCE_SALT=
alias release='mvn -B release:clean release:prepare release:perform'
alias serwer='ssh serwer@192.168.0.54 -p 1922'
alias serwersftp='sftp -P 1922 serwer@192.168.0.54'
alias testserwer='ssh serwer@192.168.1.113'
alias g='gradle'
echo "=======================================";
