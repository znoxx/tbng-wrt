# tbng-wrt

This small set of scripts creates TOR AP functionality to your OpenWRT device.

Tested on OpenWRT 18.06, should be compatible with future releases.
## What it does
* Installs TOR
* Adds additional config to TOR
* Adds scripts to switch on/off "all TOR"/"direct" traffic
* Adds ability to do it from UI
* Adds "halt" functionality to UI
## Installation

* Make sure device functionality is fine (you can use it as AP and access internet via it).
* Make sure you have enough space on root filesystem to perform installation of TOR and kmod-ipt-nat-extra

Put installation folder (the clone of this project) somwhere, e.g. /tmp. Let's assume path is `/tmp/tbng-wrt`.

Login to device console via SSH (or serial, or whatever you do it)

```
cd /tmp/tbng-wrt
./install.sh
```
If you see prompt:

`********** Installation Finished ***********`

Everything is set up. Now edit `/usr/local/bin/tbng_tor.sh` and set interface name to appropriate. Most probably _lan_ name is ok for most users, but on some systems, like VirtualBox interface is called "mng".

To check your interface name - go to Network-Interfaces in browser (http://<device>/cgi-bin/luci/admin/network/network).

After editing run sequentually:

```
/usr/local/bin/tbng_tor.sh
/usr/local/bin/tbng_direct.sh
```
No errors must show up.
## Usage

From UI select TBNG-WRT - TOR traffic to bypass all TCP traffic through TOR from all connected devices or TBNG-WRT - Direct traffic for normal operation.

Same can be achieved from CLI by using scripts `/usr/local/bin/tbng_tor.sh`and `/usr/local/bin/tbng_direct.sh`.

Also you can "halt" your device from TBNG-WRT menu. This is handy feature for small mobile routers with external root on usb flash to avoid filesystem corruption while powering off.

## Adjusting TOR settings

One can change TOR settings by editing `/etc/torrc.tbng-wrt` to avoid changing original torrc. 

Actually for "increased paranoia" 0.0.0.0 address can be changed to actual LAN address (e.g. 192.168.1.1 or whatever is used). TOR socks, dns and transport are not accessible from WAN side anyway, if you did not disabled OpenWRT default firewall intentionally. But again, it is possible and may be more secure to use real address instead of default 0.0.0.0.

TOR restart from UI or CLI (`/etc/init.d/tor restart`) is required after to apply changes.


Current settings are optimized for minimal resources consumption, however your mileage may vary. 