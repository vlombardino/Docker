## MACVLAN - Single Address
Create a single macvlan network.
```
docker network create -d macvlan -o parent=eth0 --subnet=192.168.1.0/24 --gateway=192.168.1.1 --ip-range=192.168.1.99/32 ContainerName
```
Add routing rule so host can see container.
```
ip link add macvlan link eth0 type macvlan mode bridge
ip link set macvlan up
ip route add 192.168.1.99/32 dev macvlan
```
---
## Reference
https://www.travisgeis.com/2020/07/05/homeassistant-in-docker-on-synology-nas/
