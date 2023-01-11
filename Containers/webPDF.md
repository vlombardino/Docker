# [webPDF](https://hub.docker.com/r/softvisiondev/webpdf/)

### Operating System & Software
- Proxmox CT & Synology
- Ubuntu 22.04
- Docker

---

Proxmox CT
```
docker run -d \
	--name webpdf \
	-e TZ=America/Los_Angeles \
	-p 8844:8080 \
	--restart unless-stopped \
	softvisiondev/webpdf:latest
```
Synology
```
docker run -d --name webpdf -e TZ=America/Los_Angeles -p 8844:8080 --restart unless-stopped softvisiondev/webpdf:latest
```
---

### Web Access
```
http://localhost:8844/webPDF/
```
