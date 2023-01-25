# [Planka](https://github.com/plankanban/planka)

### Operating System
- Synology
- Docker

---

```
version: '3'

services:
  planka:
    image: ghcr.io/plankanban/planka:latest
    command: >
      bash -c
        "for i in `seq 1 30`; do
          ./start.sh &&
          s=$$? && break || s=$$?;
          echo \"Tried $$i times. Waiting 5 seconds...\";
          sleep 5;
        done; (exit $$s)"
    restart: unless-stopped
    volumes:
      - /volume1/docker/planka/avatars:/app/public/user-avatars
      - /volume1/docker/planka/images:/app/public/project-background-images
      - /volume1/docker/planka/files:/app/private/attachments
    ports:
      - 3000:1337
    environment:
      - BASE_URL=http://192.168.1.XX:3000                    ########## Change ##########
      - TRUST_PROXY=0
      - DATABASE_URL=postgresql://postgres@postgres/planka
      - SECRET_KEY=SECRET_KEY Command Below                  ########## Change ##########
    depends_on:
      - postgres

  postgres:
    image: postgres:alpine
    restart: unless-stopped
    volumes:
      - /volume1/docker/planka/data:/var/lib/postgresql/data
    environment:
      - POSTGRES_DB=planka
      - POSTGRES_HOST_AUTH_METHOD=trust
```
---
### SECRET_KEY
```
openssl rand -hex 64
```

### Login Information
> Username: demo@demo.demo \
> Password: demo

### References
https://github.com/plankanban/planka
https://mariushosting.com/how-to-install-planka-on-your-synology-nas/
