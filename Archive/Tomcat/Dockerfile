FROM ubuntu:20.04

LABEL maintainer="vlombardino" \
      name="ubuntu-tomcat9-server" \
      version="0.1"

#set env variables
ENV DEBIAN_FRONTEND="noninteractive" \
    JAVA_HOME="/usr/lib/jvm/default-java" \
    CATALINA_BASE="/var/lib/tomcat9" \
    CATALINA_HOME="/usr/share/tomcat9" \
    CATALINA_TMPDIR="/tmp" \
    TZ="America/Los_Angeles" \
#user and password for tomcat-users.xml
    TOM_USER="admin" \
    TOM_PASS="admin"

#add needed files
COPY tomcat-files/ /tmp/

#install packages & clean up
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
    	default-jdk-headless \
        tomcat9 \
        tomcat9-admin \
        tomcat9-docs \
        tomcat9-examples && \
    apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
#configure image
    mv /var/lib/tomcat9/webapps/ROOT /tmp/ && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    ln -s /var/lib/tomcat9/webapps /srv/ && \
    ln -s /var/lib/tomcat9/logs /srv/ && \
    chmod +x /tmp/docker-entrypoint.sh && \
    mv /tmp/docker-entrypoint.sh /usr/local/bin/ && \
    mv /tmp/tomcat-users.xml /etc/tomcat9/tomcat-users.xml.mod

#expose volumes
VOLUME ["/srv/webapps","/srv/logs","/opt"]

#start tomcat
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

#working dir
WORKDIR /srv

#tomcat port
EXPOSE 8080               
