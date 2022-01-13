# Installing Portainer 2.0
Create *portainer_data* volume
```
docker volume create portainer_data
```
Command to install Portainer 2.0.
```
docker run -d -p 9000:9000 -p 8000:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
```
---
# Add additional Environments
Create directory for file.
```
sudo mkdir -p /etc/systemd/system/docker.service.d
```
Create new file for daemon options.
```
sudo vim /etc/systemd/system/docker.service.d/options.conf
####################ADD TEXT####################
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H unix:// -H tcp://0.0.0.0:2375
################################################
```
Reload the systemd daemon.
```
sudo systemctl daemon-reload
```
Restart Docker.
```
sudo systemctl restart docker
```
## Docker Snap Install
```
sudo vim /etc/systemd/system/snap.docker.dockerd.service
####################ADD TEXT####################
ExecStart=/usr/bin/snap run docker.dockerd -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock
################################################
```

---
# Reference
https://dbtechreviews.com/2020/08/update-portainer-to-version-2-0-super-easy/
