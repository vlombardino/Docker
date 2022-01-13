# Installing Portainer 2.0
Create *portainer_data* volume
```
docker volume create portainer_data
```
Command to install Portainer 2.0.
```
docker run -d -p 9000:9000 -p 8000:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
```
# Reference
https://dbtechreviews.com/2020/08/update-portainer-to-version-2-0-super-easy/
