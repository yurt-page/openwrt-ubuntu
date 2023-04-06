# PPA for OpenWrt on Ubuntu.
Of course, OpenWrt programs can't be fully supported on Ubuntu but partially this works.
For example [uhttpd](https://openwrt.org/docs/guide-user/services/webserver/uhttpd) on Ubuntu works pretty well. To expose `/www` dir via http:

    sudo uhttpd -f -h /www -p 8080 

Also at this moment works `jshn` and `ubus` commands.

## Install on Ubuntu 18.10
The plugin can be installed in Ubuntu via [PPA](https://code.launchpad.net/~stokito/+archive/ubuntu/openwrt):

    sudo add-apt-repository ppa:stokito/openwrt
    sudo apt-get update
    sudo apt install jsonpath libubox rpcd ubus uci ustream-ssl uhttpd
    

### Build and install from sources
Each OpenWrt package is located in it's own repo and checkout as a sub repository to the directory.
The Makefile only triggers `cmake` for each of the directory in needed order.

To install from sources:

    git clone https://github.com/stokito/openwrt-ubuntu.git
    cd openwrt-ubuntu
    sudo apt install cmake pkg-config lua5.1 liblua5.1-0-dev libjson-c-dev libssl-dev
    sudo make install

#### Dependencies problem
If you would like to build only one package you anyway have to build and install dependencies.
All packages have dependency to `libubox` headers but may be others too. So to build `uhttpd`:

    make libubox/build
    sudo make libubox_install
    make ubus/build
    sudo make ubus_install
    make ustream-ssl/build
    sudo make ustream-ssl_install
    make uhttpd/build

So here we build libubox first and then installed it, then we did the same for `ubus` and `ustream-ssl`.
And only then we build the `uhttpd`.
Also quite popular is `uci`:

    make uci/build
    sudo make uci_install

BTW after that you can build the rest with just

    make

And internally will be called the target `.all`

Or build manually:

    make uclient/build
    make rpcd/build
    make jsonpath/build
    make uclient/build
    make mountd/build


#### Debian/Ubuntu packages

To build `*.deb` packages use:

    debuild

You'll see "This package has a Debian revision number but there does not seem to be  appropriate original tar file"
then press `y`es and after build check the **parent** directory for the built `*.deb` files.

#### Upload to PPA
It's not so easy to do that but try:

    debuild -S -I -sa
    dput ppa:stokito/openwrt ../openwrt_*_source.changes
 
 The `-S` means create only sources package and `-I` needed to ignore `.git` directory.
 
#### Update sources
Also you can update sources of all sub repositories:

    make pull

## uhttpd start with ubus

    sudo ubus
    sudo rpcd
    sudo uhttpd -f -h /www -p 80 -u /ubus

## Similar project
* http://www.debwrt.net/
* https://twitter.com/DebWrt

## Related articles
* https://code.launchpad.net/~stokito/openwrt/+git/openwrt
* https://stackoverflow.com/questions/31179509/install-luci-on-ubuntu-instead-of-openwrt
* https://mondwan.blogspot.com/2015/06/how-to-setup-luci-web-framework-with.html
* https://github.com/mmaraya/uhttpd2/commits/master
* https://forum.ubuntu.ru/index.php?topic=276156.0
* https://mondwan.blogspot.com/2014/06/install-luci-on-ubuntu-1204.html
* http://www.wakoond.hu/2013/06/using-uci-on-ubuntu.html


FIXME
https://github.com/stardust95/TinyCompiler/issues/2