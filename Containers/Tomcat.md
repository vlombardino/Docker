# Tomcat
Running Tomcat 10 Docker within CT on Proxmox

## Setup Ubuntu container
Update & Upgrade
```
apt update && apt upgrade -y
```
Allow root ssh access by adding PermitRootLogin
```
nano /etc/ssh/sshd_config

####################ADD TEXT####################
PermitRootLogin yes
################################################
```
Restart ssh server
```
service ssh restart
```
Set Local unicode
```
locale-gen en_US.UTF-8
```
Command to generate the ```/etc/default/locale```
```
update-locale LANG=en_US.UTF-8
```
## Install required software
```
apt install openjdk-17-jdk apt-transport-https ca-certificates curl software-properties-common -y
```

## Install Docker and Docker Compose
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update

apt install docker-ce docker-ce-cli containerd.io docker-compose docker-compose-plugin -y
```



## Get required files from tomcat
Create Tomcat 
```
docker create \
	--name=tomcat \
	-e TZ=America/Los_Angeles \
	-p 8080:8080 \
	-p 8443:8443 \
	-v /home/docker/tomcat/webapps:/usr/local/tomcat/webapps \
	--restart unless-stopped \
	tomcat:10-jre17-temurin
```
	
Start tomcat and setup config files
```
docker container start tomcat
docker exec -it tomcat sh
cp -r /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps/
cp -r /usr/local/tomcat/conf /usr/local/tomcat/webapps/
exit
docker container stop tomcat
docker container rm tomcat
```
---

## Setup tomcat for docker install

Move conf folder
```
mv /home/docker/tomcat/webapps/conf /home/docker/tomcat/
```

Edit ```context.xml``` configuration file in manager folder
```
nano /home/docker/tomcat/webapps/manager/META-INF/context.xml

####################MOD TEXT####################
  <!-- <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" /> -->
################################################
```
Edit ```context.xml``` configuration file in host-manager folder
```
nano /home/docker/tomcat/webapps/host-manager/META-INF/context.xml

####################MOD TEXT####################
  <!-- <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" /> -->
################################################
```

Edit ```tomcat-users.xml``` configuration file
```         
nano /home/docker/tomcat/conf/tomcat-users.xml

####################ADD TEXT####################
<role rolename="admin"/>
<role rolename="admin-gui"/>
<role rolename="manager"/>
<role rolename="manager-gui"/>
<user username="admin" password="admin" roles="admin,admin-gui,manager,manager-gui"/>
################################################
```

Recreate Tomcat with file changes
```
docker create \
	--name=tomcat \
	-e TZ=America/Los_Angeles \
	-p 8080:8080 \
	-p 8443:8443 \
	-v /home/docker/tomcat/conf:/usr/local/tomcat/conf \
	-v /home/docker/tomcat/webapps:/usr/local/tomcat/webapps \
	--restart unless-stopped \
	tomcat:10-jre17-temurin
	
docker container start tomcat
```

## Self Signed Certificate

Stop tomcat container
```
docker container stop tomcat
```

Make working directories
```
mkdir /home/docker/tomcat/ssl && cd /home/docker/tomcat/ssl
```

Create keystore
```
keytool -genkey -keysize 2048 -keyalg RSA -noprompt -alias tomcat -dname "CN=domain.local, OU=IT, O=Business, L=City(full name), S=State(full name), C=USA" -keystore /home/docker/tomcat/ssl/tomcat.local.jks -validity 9999 -storepass PASSWORD -keypass PASSWORD
```

Copy keystore into ```conf``` folder
```
cp /home/docker/tomcat/ssl/tomcat.local.jks /home/docker/tomcat/conf/
```

Edit ```server.xml```
```
nano /home/docker/tomcat/conf/server.xml

####################ADD TEXT####################
<Connector
	protocol="org.apache.coyote.http11.Http11NioProtocol"
	port="8443"
	maxThreads="150"
	SSLEnabled="true">
  <SSLHostConfig>
	<Certificate
		certificateKeystoreFile="conf/tomcat.local.jks"
		certificateKeystorePassword="PASSWORD"
		type="RSA"
	/>
  </SSLHostConfig>
</Connector>
################################################
```

Start tomcat container
```
docker container start tomcat
```
