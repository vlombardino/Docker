# MACVLAN - Single Address
```
docker network create -d macvlan -o parent=eth0 --subnet=192.168.1.0/24 --gateway=192.168.1.1 --ip-range=192.168.1.99/32 ContainerName
ip link add macvlan link eth0 type macvlan mode bridge
ip link set macvlan up
ip route add 192.168.1.99/32 dev macvlan
```
