echo "=======================================";
echo "loading bash profile";
# wp wp-cli
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export DB_NAME=wordpress
export DB_USER=root
export DB_PASSWORD=pass
export DB_URL="jdbc:mysql://localhost:3306/$DB_NAME?useUnicode=yes&amp;characterEncoding=UTF-8"
# composer
export PAGE_REPO=
export GITHUB_USER=
export GITHUB_OAUTH_TOKEN=
export DEV=true
export TOMCATADMINPASSWORD=
export CATALINA_HOME=/opt/tomcat
export CATALINA_OPTS="-Xms=512M -Xmx=1024M"
export GOPATH=/usr/lib/go/gopath
export PATH=$GOPATH/bin:$PATH
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
alias www='ssh r00t@192.168.0.49'
alias www2='ssh -P 2222 stronka@192.168.1.90'
alias g='gradle'
alias d='docker'
alias di='docker images'
alias dp='docker ps'
alias de='function _de() { docker exec -it $1 /bin/bash; };_de'
alias dr='function _dr() { docker run  -it $1 /bin/bash; };_dr'
alias drm='function _drm() { docker rmi -f $1 ; };_drm'
alias githistory="git log --graph --abbrev-commit --decorate --format=format:'%h - %aD (%ar)%d%n''          %s- %an' --all"
echo "=======================================";
