#!/bin/sh
###Edit name of local net interface.
###On some systems (e.g. virtualbox) it is called 'mng' instead of 'lan'
INTERFACE=lan


/usr/local/bin/tbng_direct.sh
DEVICE=`ifstatus ${INTERFACE} |  jsonfilter -e '@["device"]'`
IP=`ifstatus ${INTERFACE} |  jsonfilter -e '@["ipv4-address"][0].address'`
iptables -t nat -A PREROUTING -i ${DEVICE} -p udp --dport 53 -j REDIRECT --to-ports 9053 -m comment --comment TBNG-WRT
iptables -t nat -A PREROUTING -i ${DEVICE} '!' -d ${IP}/24 -p tcp --syn -j REDIRECT --to-ports 9040 -m comment --comment TBNG-WRT


