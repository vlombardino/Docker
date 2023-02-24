# Tomcat Server
A tomcat server to run a web application archive file (.war) in the webapps folder.

### Installed software:
* Ubuntu 20.04
* OpenJDK (11.0.7)
* Tomcat (9.0.31-1)



## Notes
Tomcat management console has been defaulted to admin:admin. If you would like to use a different username and/or password change the following:
* TOM_USER=admin
* TOM_PASS=admin


```
docker create \
  --name=ubuntu-tomcat9 \
  -e TOM_USER=admin \
  -e TOM_PASS=admin \
  -e TZ=America/Los_Angeles \
  -p 8080:8080 \
  -v /path/to/webapps:/srv/webapps \
  -v /path/to/logs:/srv/logs \
  -v /path/to/opt:/opt \
  --restart unless-stopped \
  vlombardino/ubuntu-tomcat9
```
