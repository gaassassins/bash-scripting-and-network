#!/bin/bash

echo 1 > /proc/sys/net/ipv4/conf/default/forwarding

#add namespace
ip net add h2
ip net add h3
ip net add h4

#add br0
brctl addbr br0
ifconfig br0 up

#add link between namespace
ip link add veth02_1 type veth peer name veth2_1
ip link set dev veth2_1 netns h2
brctl addif br0 veth02_1

ip link add veth02_2 type veth peer name veth2_2
ip link set dev veth2_2 netns h2
brctl addif br0 veth02_2

ip link add veth03 type veth peer name veth3
ip link set veth3 netns h3
brctl addif br0 veth03

ip link add veth04 type veth peer name veth4
ip link set veth4 netns h4
brctl addif br0 veth04

#add vlan 
ip l a link br0 name br0.10 type vlan id 10
ip l a link br0 name br0.20 type vlan id 20
ip a a 10.0.0.1/24 dev br0.10
ip a a 20.0.0.1/24 dev br0.20
ifconfig br0.10 up
ifconfig br0.20 up

ip net e h2 ip l a link veth2_1 name veth2_1.10 type vlan id 10
ip net e h2 ip a a 10.0.0.2/24 dev veth2_1.10
ip net e h2 ip l s veth2_1 up
ip l s veth02_1 up

ip net e h2 ip l a link veth2_2 name veth2_2.10 type vlan id 20
ip net e h2 ip a a 20.0.0.2/24 dev veth2_2.10
ip net e h2 ip l s veth2_2 up
ip l s veth02_2 up

ip net e h2 ip l s lo up
ip net e h3 ip l s lo up
ip net e h4 ip l s lo up

ip net e h2 ip r a default via 10.0.0.1

ip net e h3 ip l a link veth3 name veth3.10 type vlan id 10
ip net e h3 ip a a 10.0.0.3/24 dev veth3.10
ip net e h3 ip l s veth3 up
ip l s veth03 up
ip net e h3 ip r a default via 10.0.0.1

ip net e h4 ip l a link veth4 name veth4.20 type vlan id 20
ip net e h4 ip a a 20.0.0.4/24 dev veth4.20
ip net e h4 ip l s veth4 up
ip l s veth04 up
ip net e h4 ip r a default via 20.0.0.1


iptables -t nat -A PREROUTING -d 20.0.0.3 -j DNAT --to-destination 10.0.0.3


#ping
iptables -A OUTPUT -p -i veth03 icmp --icmp-type echo-request -j ACCEPT
iptables -A INPUT -p -i veth03 icmp --icmp-type echo-reply -j ACCEPT

#ping
iptables -A INPUT -p -i veth03 icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p -i veth03 icmp --icmp-type echo-reply -j ACCEPT

#accpet only 80 port access on tcp and udp
iptables -A INPUT -p udp -i veth03 --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -i veth03 --dport 80 -j ACCEPT
iptables -A INPUT -i veth03 -j DROP

