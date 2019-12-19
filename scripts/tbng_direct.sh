#!/bin/sh

iptables-save |grep TBNG-WRT|sed -E 's/-A/iptables -t nat -D/' | sh


