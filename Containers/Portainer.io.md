# [Installing Portainer](https://hub.docker.com/r/portainer/portainer-ce)
Create *portainer_data* volume
```bash
docker volume create portainer_data
```
Command to install Portainer.
```bash
docker run -d -p 9000:9000 -p 8000:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
```

Install Portainer Agent
```bash
docker run -d -p 9001:9001 --name portainer_agent --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:latest
```
>Environments -> Add environment -> Docker Standalon -> Agent


# Remove Portainer
```bash
docker stop portainer
docker rm portainer
docker volume rm portainer_data
```

---

### Connect to Docker with systemd
Create directory for file.
```bash
sudo mkdir -p /etc/systemd/system/docker.service.d
```
Create new file for daemon options.
```bash
sudo nano /etc/systemd/system/docker.service.d/options.conf
####################ADD TEXT####################
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H unix:// -H tcp://0.0.0.0:2375
################################################
```
Reload the systemd daemon.
```bash
sudo systemctl daemon-reload
```
Restart Docker.
```bash
sudo systemctl restart docker
```
Docker Snap Install
```bash
sudo vim /etc/systemd/system/snap.docker.dockerd.service
####################ADD TEXT####################
ExecStart=/usr/bin/snap run docker.dockerd -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock
################################################
```

---
# Reference
https://dbtechreviews.com/2020/08/update-portainer-to-version-2-0-super-easy/
