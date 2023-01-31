## [VS Code](https://github.com/linuxserver/docker-code-server)

### Operating System & Software
- Synology
- Docker

---

### Create folders
docker -> vscode -> config -> workspace
```
mkdir -p /volume1/docker/vscode/config/workspace
```

### Synology Docker
```
docker run -d \
  --name=code-server \
  -e PUID=1026 \
  -e PGID=100 \
  -e TZ=America/Los_Angeles \
  -e DEFAULT_WORKSPACE=/config/workspace \
  -p 8833:8443 \
  -v /volume1/docker/vscode/config:/config \
  --restart unless-stopped \
  lscr.io/linuxserver/code-server:latest
```

### Notes
Fix github error
```
docker exec -it code-server sh

git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```