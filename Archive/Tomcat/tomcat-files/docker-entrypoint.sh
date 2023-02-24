#!/bin/bash

#add user and password to tomcat-users.xml
cp -f /etc/tomcat9/tomcat-users.xml.mod /etc/tomcat9/tomcat-users.xml
sed -i "s|TOM_USER|$TOM_USER|g" /etc/tomcat9/tomcat-users.xml
sed -i "s|TOM_PASS|$TOM_PASS|g" /etc/tomcat9/tomcat-users.xml

#move ROOT folder to webapps
if [ -d "/tmp/ROOT" ]; then
   mv /tmp/ROOT /var/lib/tomcat9/webapps/ROOT
fi

sed -i -e '9,11s/^/#/' -e '13s/^/#/' /usr/local/bin/docker-entrypoint.sh

#start tomcat
exec /usr/share/tomcat9/bin/catalina.sh run
