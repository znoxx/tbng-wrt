#!/bin/sh
set -e

echo "This script installs and configures TBNG-WRT"

opkg remove tor
rm -rf /etc/tor
opkg update
opkg install tor kmod-ipt-nat-extra
cp torconf/torrc.tbng-wrt /etc/
echo "%include /etc/torrc.tbng-wrt" >> /etc/tor/torrc
mkdir -p /usr/local/bin
cp scripts/* /usr/local/bin/
chmod +x /usr/local/bin/tbng*.sh
cp -r ./luci/* /usr/lib/lua/luci/
rm -rf /var/luci-modulecache/*
/etc/init.d/uhttpd restart
/etc/init.d/tor restart

echo "********** Installation Finished ***********"
echo "Edit /usr/local/bin/tbng_tor.sh and set INTERFACE= to your lan interface!"
echo "Most probably it's already set correctly, but must be modified according to your system settings."
echo "E.g. in VirtualBox OpenWRT interface is called 'mng' instead of 'lan'"
echo "After this execute:"
echo "/usr/local/bin/tbng_tor.sh"
echo "/usr/local/bin/tbng_direct.sh"
echo "To make sure there is no errors"
echo "********************************************"

