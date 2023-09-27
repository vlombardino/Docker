# [Stirling-PDF](https://hub.docker.com/r/frooodle/s-pdf)

### Operating System & Software
- Proxmox CT & Synology
- Ubuntu 22.04
- Docker

---

Proxmox CT (docker cli)
```bash
docker run -d \
	--name stirling-pdf \
	-v /home/box/docker/data:/usr/share/tesseract-ocr/4.00/tessdata \
	-v /home/box/docker/configs:/configs \
	-e DOCKER_ENABLE_SECURITY=false \
	-p 8855:8080 \
	--restart unless-stopped \
	frooodle/s-pdf:latest
```
Synology (docker cli)
```bash
mkdir -p /volume1/docker/stirling-pdf/{data,configs}
sudo -i
docker run -d --name stirling-pdf -v /volume1/docker/stirling-pdf/data:/usr/share/tesseract-ocr/4.00/tessdata -v /volume1/docker/stirling-pdf/configs:/configs -e DOCKER_ENABLE_SECURITY=false -p 8855:8080 --restart unless-stopped frooodle/s-pdf:latest
```
---

### Web Access
```
http://localhost:8855
```
