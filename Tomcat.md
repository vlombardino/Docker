# [Tomcat - Official Image](https://hub.docker.com/_/tomcat)

## Build Tomcat Image

Dockerfile
```
vim Dockerfile
####################ADD TEXT####################
FROM tomcat:9.0.56-jdk17-openjdk

LABEL maintainer="vlombardino" \
      name="tomcat9-server" \
      version="0.1"

COPY entrypoint.sh /usr/local/bin/
   
#configure image      
RUN mkdir /tmp/tomcat && \
    rm -rf /usr/local/tomcat/webapps && \
    mv -f /usr/local/tomcat/webapps.dist /usr/local/tomcat/webapps && \
    mv -f /usr/local/tomcat/* /tmp/tomcat/ && \
    ln -s /usr/local/tomcat /srv/

#tomcat port
EXPOSE 8080 8443

#expose volumes
VOLUME ["/srv/tomcat"]

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["catalina.sh", "run"]
################################################
```

Create entrypoint file
```
vim entrypoint.sh
####################ADD TEXT####################
#!/bin/sh
STARTUP_FILE="STARTUP_FILE"
if [ ! -e /$STARTUP_FILE ]; then
   # This part runs at initial startup.
   touch /$STARTUP_FILE
   echo "This file is needed for the initial startup. DO NOT REMOVE!" >> /$STARTUP_FILE
   echo "File location /usr/local/bin/entrypoint.sh" >> /$STARTUP_FILE
   mv -f /tmp/tomcat/* /usr/local/tomcat/
   echo "First Startup"
else
   # This part continues to run after initial startup.
   echo "Image Version: tomcat:9.0.56-jdk17-openjdk"
fi

exec "$@"
################################################
```
Build image
```
docker build -t tomcat9 .
or
docker build -f Dockerfile -t tomcat9 .
```

## Modify files
Modify the following files:

> /usr/local/tomcat/conf/tomcat-users.xml

> /usr/local/tomcat/webapps/manager/META-INF/context.xml

> /usr/local/tomcat/webapps/host-manager/META-INF/context.xml

---

Configure Tomcat user configuration file. Change USER & PASS
```
cp /usr/local/tomcat/conf/tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml.orig
vim /usr/local/tomcat/conf/tomcat-users.xml
####################ADD TEXT####################
<role rolename="admin"/>
<role rolename="admin-gui"/>
<role rolename="manager"/>
<role rolename="manager-gui"/>
<user username="USER" password="PASS" roles="admin,admin-gui,manager,manager-gui"/>
################################################
```

Edit Tomcat context file for manager. Comment out block.
```
cp /usr/local/tomcat/webapps/manager/META-INF/context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml.orig
vim /usr/local/tomcat/webapps/manager/META-INF/context.xml
####################MOD TEXT####################
<!-- <Valve className="org.apache.catalina.valves.RemoteAddrValve"
allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" /> -->
################################################
```

Edit Tomcat context file for host-manager. Comment out block.
```
cp /usr/local/tomcat/webapps/host-manager/META-INF/context.xml /usr/local/tomcat/webapps/host-manager/META-INF/context.xml.orig
vim /usr/local/tomcat/webapps/host-manager/META-INF/context.xml
####################MOD TEXT####################
<!-- <Valve className="org.apache.catalina.valves.RemoteAddrValve"
allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" /> -->
################################################
```

## Docker cli
```
docker create \
  --name=tomcat9 \
  -e PUID=1000 \
  -e PGID=1000 \
  -e UMASK=000 \
  -e TZ=America/Los_Angeles \
  -p 8080:8080 \
  -p 8443:8443 \
  -v /path/to/tomcat:/srv/tomcat \
  --restart unless-stopped \
  tomcat9
```
