# Plex (nvidia)

### Operating System & Software
- Proxmox VM
- Ubuntu server 22.04
- [GPU Passthrough](https://github.com/vlombardino/Proxmox/blob/master/VM/GPU%20Passthrough%20Ubuntu.md)
- Docker

---

### Docker install
```bash
sudo apt install apt-transport-https ca-certificates curl software-properties-common

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io docker-compose
```

### Docker compose install [[latest version](https://github.com/docker/compose/releases)]
```bash
sudo curl -L "https://github.com/docker/compose/releases/download/v2.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
```

### Allow user to configure Docker
```bash
sudo usermod -aG docker $USER

sudo reboot
```

### Check Docker & Docker Compose version
```bash
docker -v

docker-compose -v
```

### Nvidia drivers
```
ubuntu-drivers devices

sudo ubuntu-drivers autoinstall
```
or
```bash
ubuntu-drivers devices

sudo apt install nvidia-driver-535-server

sudo reboot
```

### [Nvidia container toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker)
```bash
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
	&& curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
	&& curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
	sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
	sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

sudo apt update

sudo apt install nvidia-docker2 -y

sudo systemctl restart docker
```

### Test nvidia in docker
```bash
nvidia-smi

sudo docker run --rm --gpus all nvidia/cuda:11.0.3-base-ubuntu20.04 nvidia-smi
```

### Docker volume (NFS)
```bash
docker volume create \
	--driver local \
	--opt type=nfs4 \
	--opt o=addr=192.168.1.80,rw,noatime,rsize=8192,wsize=8192,tcp,timeo=14 \
	--opt device=:/volume3/PlexMedia \
	media
```

### Docker containers
>[Portainer](https://github.com/vlombardino/Docker/blob/main/Portainer.io.md)
```bash
docker volume create portainer_data

docker run -d -p 9000:9000 -p 8000:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
```

>[Plex](https://hub.docker.com/r/linuxserver/plex)\
> Optional: [[-e PLEX_CLAIM=#token](https://plex.tv/claim)]
```bash
docker run -d \
  --name=plex \
  --net=host \
  --runtime=nvidia \
  -e PUID=1000 \
  -e PGID=1000 \
  -e VERSION=docker \
  -e PLEX_CLAIM=#token \
  -e NVIDIA_VISIBLE_DEVICES=all \
  -v /home/plex/docker/plex/config:/config \
  -v media:/media \
  --restart unless-stopped \
  lscr.io/linuxserver/plex:latest
```

>[Tautulli](https://hub.docker.com/r/linuxserver/tautulli)
```bash
docker run -d \
  --name=tautulli \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=America/Los_Angeles \
  -p 8181:8181 \
  -v /home/plex/docker/tautulli/config:/config \
  --restart unless-stopped \
  lscr.io/linuxserver/tautulli:latest
```
