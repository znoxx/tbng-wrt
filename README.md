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

* Make sure device functionality is fine (you can use it as AP or wired router and access internet via it).
* Make sure you have enough space on root filesystem to perform installation of TOR and kmod-ipt-nat-extra.

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

## Using TOR bridges (untested)

OpenWRT (as per version 18.06) does not support obfs4 bridges, however one can e.g. obfs3 tunnels.

Actually, I have _not_ succeded with running TOR via bridges, but it should work. Installation is manual.

### Steps

#### Install package _obfsproxy_

```
opkg update
opkg install obfsproxy
```

#### Adjust settings in original _/etc/tor/torrc_ -- include obfs-related config:

###this is what you have after successfull tbng-wrt setup
%include /etc/torrc.tbng-wrt
###this is what you have to add
%include /etc/torrc.obfs

#### Edit your /etc/torrc.obfs

```
#####Uncomment and fill below

#UseBridges 1
#ClientTransportPlugin obfs2,obfs3,scramblesuit exec /usr/bin/obfsproxy managed

###Place your bridges here:

#bridge obfs3 -----------
#bridge scramblesuit ----------
````

#### Get some bridges

Probably, you know how to do it. Or consult http://bridges.torproject.org

Edit again _/etc/torrc.obfs_ and uncomment everything starting from single `#`character. Modify strings with `-----`with actual bridge settings.

#### Start using it

Restart TOR. It should pick your config and your bridges and startup. __Warning__ -- it looks, that bridge using requires more CPU/RAM, that usual TOR activity and not-so-powerful routers can choke on this. Follow your syslog to check the current activity.





