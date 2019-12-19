# tbng-wrt

luci content goes to /usr/lib/lua/luci
scripts content goes to /usr/local/bin/
torconf content goes to /etc

opkg remove tor
rm -rf /etc/tor
opkg install tor
---copy torconf
echo "%include /etc/torrc.tbng-wrt" >> /etc/tor/torrc
---copy scripts
---copy lua
---reboot

