## MACVLAN - Single Address
Create a macvlan network for a single ip address.
```
docker network create -d macvlan -o parent=eth0 --subnet=192.168.1.0/24 --gateway=192.168.1.1 --ip-range=192.168.1.99/32 macvlanname
```
Create docker image of Ubuntu running on ip address from macvlan
```
docker run -rm -it -name Ubuntu --ip 192.168.1.98 --network macvlanname ubuntu:latest bash
```

Add routing rule so host can see container.
```
ip link add macvlan link eth0 type macvlan mode bridge
ip link set macvlan up
ip route add 192.168.1.99/32 dev macvlan
```

## MACVLAN - vlan
```
docker network create -d macvlan -o parent=eth0.10 --subnet=192.168.10.0/24 --gateway=192.168.10.1 macvlan10
```

## IPVLAN
```
docker network create -d ipvlan -o parent=eth0.10 --subnet=192.168.10.0/24 --gateway=192.168.10.1 macvlan10
```

---
## Reference
https://www.travisgeis.com/2020/07/05/homeassistant-in-docker-on-synology-nas/
