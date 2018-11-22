# PPA for OpenWrt on Ubuntu.
Off course, OpenWrt programs can't be fully supported on Ubuntu but partially this works.
For example [uhttpd](https://openwrt.org/docs/guide-user/services/webserver/uhttpd) on Ubuntu works pretty well. For example, to expose `/www` dir via http:

    sudo uhttpd -f -h /www -p 80 

Also at this moment works `jshn` and `ubus` commands.

## Install on Ubuntu 18.10
The plugin can be installed in Ubuntu via [PPA](https://code.launchpad.net/~stokito/+archive/ubuntu/pidgin-fchat):

    sudo add-apt-repository ppa:stokito/openwrt
    sudo apt-get update
    sudo apt install libubox ubus ustream-ssl uhttpd
    

### Build and install from sources
To install from sources:

    git clone https://github.com/stokito/openwrt-ubuntu.git
    cd openwrt-ubuntu
    sudo apt install cmake lua5.1 lliblua5.1-0-dev libjson-c-dev
    make
    sudo make install
