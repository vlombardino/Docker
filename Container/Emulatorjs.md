## [Emulatorjs](https://github.com/linuxserver/docker-emulatorjs)
#### Proxmox Container
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

## Controls
#### Keyboard
```
Menu Settings -> F1 
Insert Coin -> 5 & 6
Start & Select -> Enter & R-Shift
Right, Left, Up, Down -> Arror Keys
Buttons -> Z, X, L-CTR, L-ALT, L-Shift
Quit Game -> Esc (Twice), ALT + Right Arrow
```


## References
https://github.com/linuxserver/docker-emulatorjs
