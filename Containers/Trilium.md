# [Trilium](https://github.com/zadam/trilium/wiki/Docker-server-installation)

### Operating System & Software
- Proxmox CT & Synology
- Ubuntu 22.04
- Docker

---

Proxmox CT (docker cli)
```bash
docker run -d \
	--name trilium \
	-v /volume1/docker/trilium:/home/node/trilium-data \
	-p 8444:8080 \
	--restart unless-stopped \
	zadam/trilium:latest
```
Synology (docker cli)
```bash
mkdir -p /volume1/docker/trilium
sudo -i
docker run -d --name trilium -v /volume1/docker/trilium:/home/node/trilium-data -p 8444:8080 --restart unless-stopped zadam/trilium:latest
```
---

### Web Access
```
http://localhost:8444
```
