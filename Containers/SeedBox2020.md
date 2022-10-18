# Ubuntu Server 20.04

Initial setup
> Install Ubuntu with *box* as default user.
```
sudo apt install openssh-server vim htop qemu-guest-agent
sudo apt install cockpit (cockpit-*)
wget https://launchpad.net/ubuntu/+source/cockpit/215-1~ubuntu19.10.1/+build/18889196/+files/cockpit-docker_215-1~ubuntu19.10.1_all.deb
sudo dpkg -i cockpit-docker_215-1~ubuntu19.10.1_all.deb
```

NFS setup
> Synology NFS setup (Read/Write, Map all users to admin,sys, Enable asynchronous, Allow users to access mounted subfolders)
```
sudo apt install nfs-common
mkdir -p /home/box/Media
sudo vim /etc/fstab
192.168.1.10:/volume1/Media /home/box/Media nfs rw,user 0 0
sudo mount -a
```

Install and configure docker(snap)
```
sudo snap install docker
sudo addgroup --system docker
sudo adduser $USER docker
newgrp docker
sudo snap disable docker
sudo snap enable docker
```

Create folders
```
mkdir -p /home/box/docker/{portainer,jackett,nzbget,delugevpn,bazarr,sonarr,radarr,handbrake,filebrowser}/config
mkdir -p /home/box/downloads/{completed/{movies,music,other,tv},incomplete,intermediate,nzb,queue,tmp,watch,handbrake/{converted,storage,watch}}

```

[Portainer 2](https://hub.docker.com/r/portainer/portainer-ce)
```
docker volume create portainer_data
docker run -d -p 9000:9000 -p 8000:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
```

## Selfhosted Templates for portainer
Portainer Templates for Selfhosted Projects/Homelabs
[SelfhostedPro](https://github.com/SelfhostedPro/selfhosted_templates)


## Manual install
docker cli / docker-compose

[Jackett](https://hub.docker.com/r/linuxserver/jackett)
```
docker create \
	--name=jackett \
	-e PUID=1000 \
	-e PGID=1000 \
	-e TZ=America/Los_Angeles \
	-e AUTO_UPDATE=true \
	-p 9117:9117 \
	-v /home/box/docker/jackett/config:/config \
	-v /home/box/downloads/tmp:/downloads \
	--restart unless-stopped \
	linuxserver/jackett
```

[Nzbget](https://hub.docker.com/r/linuxserver/nzbget)
```
docker create \
	--name=nzbget \
	-e PUID=1000 \
	-e PGID=1000 \
	-e TZ=America/Los_Angeles \
	-p 6789:6789 \
	-v /home/box/docker/nzbget/config:/config \
	-v /home/box/downloads:/downloads \
	--restart unless-stopped \
	linuxserver/nzbget
```

[Deluge VPN](https://github.com/binhex/arch-delugevpn)
```
docker create \
	--cap-add=NET_ADMIN \
	-p 8112:8112 \
	-p 8118:8118 \
	-p 58846:58846 \
	-p 58946:58946 \
	--name=delugevpn \
	-v /home/box/downloads:/data \
	-v /home/box/docker/delugevpn/config:/config \
	-v /etc/localtime:/etc/localtime:ro \
	-e VPN_ENABLED=yes \
	-e VPN_USER=USERNAME \
	-e VPN_PASS=PASSWORD \
	-e VPN_PROV=custom \
	-e STRICT_PORT_FORWARD=yes \
	-e ENABLE_PRIVOXY=yes \
	-e LAN_NETWORK=192.168.1.0/24 \
	-e NAME_SERVERS=209.222.18.222,84.200.69.80,37.235.1.174,1.1.1.1,209.222.18.218,37.235.1.177,84.200.70.40,1.0.0.1 \
	-e DELUGE_DAEMON_LOG_LEVEL=info \
	-e DELUGE_WEB_LOG_LEVEL=info \
	-e ADDITIONAL_PORTS=1234 \
	-e DEBUG=false \
	-e UMASK=000 \
	-e PUID=1000 \
	-e PGID=1000 \
	--restart unless-stopped \
	binhex/arch-delugevpn
```

[Bazarr](https://hub.docker.com/r/linuxserver/bazarr)
```
docker create \
	--name=bazarr \
	-e PUID=1000 \
	-e PGID=1000 \
	-e TZ=America/Los_Angeles \
	-e UMASK_SET=000 \
	-p 6767:6767 \
	-v /home/box/docker/bazarr/config:/config \
	-v /home/box/Media/Movies:/movies \
	-v /home/box/Media/Animation:/animation \
	-v /home/box/Media/TV:/tv \
	--restart unless-stopped \
	linuxserver/bazarr
```

[Sonarr](https://hub.docker.com/r/linuxserver/sonarr)
```
docker create \
	--name=sonarr \
	-e PUID=1000 \
	-e PGID=1000 \
	-e TZ=America/Los_Angeles \
	-e UMASK_SET=000 \
	-p 8989:8989 \
	-v /home/box/docker/sonarr/config:/config \
	-v /home/box/Media/TV:/tv \
	-v /home/box/downloads:/downloads \
	--restart unless-stopped \
	linuxserver/sonarr
```

[Radarr](https://hub.docker.com/r/linuxserver/radarr)
```
docker create \
	--name=radarr \
	-e PUID=1000 \
	-e PGID=1000 \
	-e TZ=America/Los_Angeles \
	-e UMASK_SET=000 \
	-p 7878:7878 \
	-v /home/box/docker/radarr/config:/config \
	-v /home/box/Media/Movies:/movies \
	-v /home/box/Media/Animation:/animation \
	-v /home/box/downloads:/downloads \
	--restart unless-stopped \
	linuxserver/radarr
```

[Handbrake](https://hub.docker.com/r/jlesage/handbrake/)
> Fork with nvenc support: [zocker-160/handbrake-nvenc-docker(nvidia)](https://github.com/zocker-160/handbrake-nvenc-docker)
```
docker create \
	--name=handbrake \
	-e UMASK=000 \
	-e TZ=America/Los_Angeles \
	-p 5800:5800 \
	-v /home/box/docker/handbrake/config:/config:rw \
	-v /home/box/docker/handbrake/storage:/storage:ro \
	-v /home/box/downloads/handbrake/watch:/watch:rw \
	-v /home/box/downloads/handbrake/converted:/output:rw \
	--restart unless-stopped \
	jlesage/handbrake
```

[Filebrowser](https://hub.docker.com/r/hurlenko/filebrowser)
```
docker create \
	--name filebrowser \
	--user $(id -u):$(id -g) \
	-p 8080:8080 \
	-v /home/box:/data \
	-v /home/box/docker/filebrowser/config:/config \
	-e FB_BASEURL=/filebrowser \
	--restart unless-stopped \
	hurlenko/filebrowser
```

[Plex](https://www.plex.tv/)
##### Portainer -> Stacks
```
---
version: "2.1"
services:
  plex:
    image: lscr.io/linuxserver/plex
    container_name: plex
    network_mode: host
    environment:
      - PUID=1000
      - PGID=1000
      - VERSION=docker
    volumes:
      - /home/box/docker/plex/config:/config
      - /home/box/Media/TV:/tv
      - /home/box/Media/Movies:/movies
      - /home/box/Media/Animation:/animation
      - /home/box/Media/Optimized:/optimized
    restart: unless-stopped
```
