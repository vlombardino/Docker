  ### [Emulatorjs](https://github.com/linuxserver/docker-emulatorjs)
> Proxmox Container
```
docker run -d \
  --name=emulatorjs \
  -e PUID=0 \
  -e PGID=0 \
  -e TZ=America/Los_Angeles \
  -p 3000:3000 \
  -p 8080:80 \
  -v /home/docker/emulatorjs/config:/config \
  -v /home/docker/emulatorjs/data:/data \
  --restart unless-stopped \
  lscr.io/linuxserver/emulatorjs:latest
```

### References
https://github.com/linuxserver/docker-emulatorjs
