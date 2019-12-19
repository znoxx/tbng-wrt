#!/bin/sh
/usr/local/bin/tbng_direct.sh
DEVICE=`ifstatus lan |  jsonfilter -e '@["device"]'`
IP=`ifstatus lan |  jsonfilter -e '@["ipv4-address"][0].address'`
iptables -t nat -A PREROUTING -i ${DEVICE} -p udp --dport 53 -j REDIRECT --to-ports 9053 -m comment --comment TBNG-WRT
iptables -t nat -A PREROUTING -i ${DEVICE} '!' -d ${IP}/24 -p tcp --syn -j REDIRECT --to-ports 9040 -m comment --comment TBNG-WRT


