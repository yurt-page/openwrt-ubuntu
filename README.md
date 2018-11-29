# PPA for OpenWrt on Ubuntu.
Of course, OpenWrt programs can't be fully supported on Ubuntu but partially this works.
For example [uhttpd](https://openwrt.org/docs/guide-user/services/webserver/uhttpd) on Ubuntu works pretty well. To expose `/www` dir via http:

    sudo uhttpd -f -h /www -p 80 

Also at this moment works `jshn` and `ubus` commands.

## Install on Ubuntu 18.10
The plugin can be installed in Ubuntu via [PPA](https://code.launchpad.net/~stokito/+archive/ubuntu/pidgin-fchat):

    sudo add-apt-repository ppa:stokito/openwrt
    sudo apt-get update
    sudo apt install jsonpath libubox rpcd ubus uci ustream-ssl uhttpd
    

### Build and install from sources
To install from sources:

    git clone https://github.com/stokito/openwrt-ubuntu.git
    cd openwrt-ubuntu
    sudo apt install cmake lua5.1 liblua5.1-0-dev libjson-c-dev
    make
    sudo make install

To build `*.deb` packages use:    

    debuild

## uhttpd start with ubus

    sudo ubus
    sudo rpcd
    sudo uhttpd -f -h /www -p 80 -u /ubus

## Similar project
* http://www.debwrt.net/
* https://twitter.com/DebWrt

## Related articles
*https://code.launchpad.net/~stokito/openwrt/+git/openwrt
*https://stackoverflow.com/questions/31179509/install-luci-on-ubuntu-instead-of-openwrt
*https://mondwan.blogspot.com/2015/06/how-to-setup-luci-web-framework-with.html
*https://github.com/mmaraya/uhttpd2/commits/master
*https://forum.ubuntu.ru/index.php?topic=276156.0
*https://mondwan.blogspot.com/2014/06/install-luci-on-ubuntu-1204.html
*http://www.wakoond.hu/2013/06/using-uci-on-ubuntu.html
