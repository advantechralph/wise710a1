#!/bin/bash

#
#           [ LAN: eth1 ]  -  [ NAT / Firewall ]  -  [ WAN - eth0 ]
#            10.10.10.1                            DHCP: 172.17.8.135
#                |                                          |
#                |                                          |
#                |	                                    |
#                v                                          v
#     [ LAN PC : 10.10.10.100 ]                  [ Gateway: 172.17.9.254 ] 

# This is a testing script, the WAN port needs to get IP address by DHCP first. 

# Enable IP forward
# echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -w net.ipv4.ip_forward=1

# Set LAN Port static IP
ip addr add 10.10.10.1/24 dev eth1

# Stateful Firewall
iptables -P FORWARD DROP
iptables -A FORWARD -i eth1 -j ACCEPT
iptables -A FORWARD -i eth0 -j ACCEPT -m state --state RELATED,ESTABLISHED

# IP maquerade
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE


