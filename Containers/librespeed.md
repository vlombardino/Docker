# [librespeed](https://hub.docker.com/r/linuxserver/librespeed)

### Operating System & Software
- Proxmox CT & Synology
- Ubuntu 22.04
- Docker

---

Proxmox CT (docker cli)
```bash
docker run -d \
  --name librespeed \
  -e PUID=1026 \
  -e PGID=100 \
  -e TZ=America/Los_Angeles \
  -e PASSWORD=P@SSW0RD \
  -p 8888:80 \
  -v /volume1/docker/librespeed/config:/config \
  --restart unless-stopped \
  lscr.io/linuxserver/librespeed:latest
```

---

### Web Access
```
http://localhost:8888
```

### Notes
Add the following to `config/www/index.html` to have a link to https://librespeed.org
```html
	<br>
	<a href="https://librespeed.org" target="_blank" rel="noopener noreferrer">External Speed Test</a>
	<br>
	<br>
	<a href="https://github.com/librespeed/speedtest" target="_blank" rel="noopener noreferrer">Source code</a>
```