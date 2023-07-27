# [File Browser](https://hub.docker.com/r/hurlenko/filebrowser)

### Operating System & Software
- Ubuntu 22.04
- Docker

---

Ubuntu (docker cli)
```bash
docker create \
  --name filebrowser \
  --user $(id -u):$(id -g) \
  -p 8080:8080 \
  -v /home:/data \
  -v /home/box/docker/filebrowser/config:/config \
  -e FB_BASEURL=/filebrowser \
  --restart unless-stopped \
  hurlenko/filebrowser
```

---

### Web Access
```
http://localhost:8080
```
