## [Emulatorjs](https://github.com/linuxserver/docker-emulatorjs)

### Operating System & Software
- Proxmox CT
- Ubuntu 22.04
- Docker

---

### Proxmox Container
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

### Controls
####  Quick Keyboard Controls
```
Menu Settings = F1 
Insert Coin = 5 & 6
Start & Select = Enter & R-Shift
Right, Left, Up, Down = Arror Keys
Buttons = Z, X, L-CTR, L-ALT, L-Shift
Quit Game = Esc (Twice), ALT + Right Arrow
```

#### RetroArch Keyboard Mapping 
```
# Face Buttons
Button a = X
Button b = Z
Button x = S
Button y = A

# D-Pad
Down Arrow = Down
Left Arrow = Left
Right Arrow = Right
Up Arrow = Up

# Shoulder Buttons
Button l = Q
Button r = W

# Start and Select
Select = R-Shift
Start = Enter

# Toggle Menu
Menu Toggle = F1

# Quit RetroArch
Exit Emulator = ESC

# Toggle Fullscreen
Toggle Fullscreen = F

# Soft Reset
Reset = H

# Screenshot key
Screenshot = F8

# Mouse Grab Toggle
Grab Mouse Toggle = F11

# Game Focus Toggle
# When toggled on, all RetroPad keybinds and hotkeys are ignored by the frontend, only using the core's RetroKeyboard binds.
# Does not affect joypad button binds.
Game Focus Toggle = Scroll Lock

# Fast Forward, Slow Motion, Rewind, Pause, and Frame Advance
Toggle Fast Forward = Space
Hold Fast Forward = L
Slowmotion = E
Rewind = R
Pause Toggle = P
Frame Advance = K

# Save State controls
Load State = F4
Save State = F2
State Slot Decrease = F6
State Slot Increase = F7

# Movie Record Toggle
Movie Record Toggle = O

# Next/Previous Shader
Shader Next = M
Shader Prev = N

# Cheat controls
Cheat Toggle = U
Cheat Index Minus = T
Cheat Index Plus = Y

# OSK and Overlay
Osk Toggle = F12

# Neplay Flip Players
Netplay Flip Players = I

# Volume controls
Volume Down = Subtract
Volume Up = Add
Audio Mute = F9
```


## References
https://github.com/linuxserver/docker-emulatorjs
