#Standard stuff here
.PHONY: all clean pull libubox_install uci_install ubus_install ustream-ssl_install uhttpd_install rpcd_install mountd_install jsonpath_install install uninstall

#jsonpath/build rpcd/install
all: libubox/build ubus/build uci/build ustream-ssl/build uhttpd/build mountd/build

install: libubox_install uci_install ubus_install ustream-ssl_install uhttpd_install mountd_install

uninstall:
	if [ -f ./libubox/build/install_manifest.txt ]; then xargs rm -f < ./libubox/build/install_manifest.txt; fi
	if [ -f ./uci/build/install_manifest.txt ]; then xargs rm -f < ./uci/build/install_manifest.txt; fi
	if [ -f ./ubus/build/install_manifest.txt ]; then xargs rm -f < ./ubus/build/install_manifest.txt; fi
	if [ -f ./ustream-ssl/build/install_manifest.txt ]; then xargs rm -f < ./ustream-ssl/build/install_manifest.txt; fi
	if [ -f ./uhttpd/build/install_manifest.txt ]; then xargs rm -f < ./uhttpd/build/install_manifest.txt; fi
	if [ -f ./rpcd/build/install_manifest.txt ]; then xargs rm -f < ./rpcd/build/install_manifest.txt; fi
	if [ -f ./mountd/build/install_manifest.txt ]; then xargs rm -f < ./mountd/build/install_manifest.txt; fi
	if [ -f ./jsonpath/build/install_manifest.txt ]; then xargs rm -f < ./jsonpath/build/install_manifest.txt; fi

libubox/build:
	mkdir ./libubox/build
	cd ./libubox/build; cmake -DCMAKE_INSTALL_PREFIX=${DESTDIR}/usr -DLUAPATH=/usr/lib/x86_64-linux-gnu/lua/5.1 -DBUILD_EXAMPLES=OFF .. ; make

libubox_install: libubox/build
	cd ./libubox/build; make DESTDIR=$(DESTDIR) install

uci/build: libubox/build
	mkdir ./uci/build
	cd ./uci/build; cmake -DCMAKE_INSTALL_PREFIX=${DESTDIR}/usr -DLUAPATH=/usr/lib/x86_64-linux-gnu/lua/5.1 .. ; make

uci_install: uci/build libubox_install
	cd ./uci/build; make DESTDIR=$(DESTDIR) install

ubus/build: libubox/build
	mkdir ./ubus/build
	cd ./ubus/build; cmake -DCMAKE_INSTALL_PREFIX=${DESTDIR}/usr -DLUAPATH=/usr/lib/x86_64-linux-gnu/lua/5.1 -DBUILD_EXAMPLES=OFF .. ; make

ubus_install: ubus/build libubox_install
	cd ./ubus/build; make DESTDIR=$(DESTDIR) install

ustream-ssl/build: libubox/build
	mkdir ./ustream-ssl/build
	cd ./ustream-ssl/build; cmake -DCMAKE_INSTALL_PREFIX=${DESTDIR}/usr .. ; make

ustream-ssl_install: ustream-ssl/build libubox_install
	cd ./ustream-ssl/build; make DESTDIR=$(DESTDIR) install

uhttpd/build: libubox/build ustream-ssl/build ubus/build
	mkdir ./uhttpd/build
	cd ./uhttpd/build; cmake -DCMAKE_INSTALL_PREFIX=${DESTDIR}/usr .. ; make

uhttpd_install: uhttpd/build libubox_install ustream-ssl_install ubus_install
	cd ./uhttpd/build; make DESTDIR=$(DESTDIR) install

rpcd/build: libubox/build ubus/build uci/build
	mkdir ./rpcd/build
	cd ./rpcd/build; cmake -DCMAKE_INSTALL_PREFIX=${DESTDIR}/usr -DIWINFO_SUPPORT=OFF .. ; make

rpcd_install: rpcd/build libubox_install ubus_install uci_install
	cd ./rpcd/build; make DESTDIR=$(DESTDIR) install

mountd/build: libubox/build uci/build
	mkdir ./mountd/build
	cd ./mountd/build; cmake -DCMAKE_INSTALL_PREFIX=${DESTDIR}/usr .. ; make

mountd_install: mountd/build libubox_install uci_install
	cd ./mountd/build; make DESTDIR=$(DESTDIR) install

jsonpath/build: libubox/build
	mkdir ./jsonpath/build
	cd ./jsonpath/build; cmake -DCMAKE_INSTALL_PREFIX=${DESTDIR}/usr .. ; make

jsonpath_install: jsonpath/build libubox_install
	cd ./jsonpath/build; make DESTDIR=$(DESTDIR) install

clean:
	rm -rf ./libubox/build
	rm -rf ./ubus/build
	rm -rf ./uci/build
	rm -rf ./ustream-ssl/build
	rm -rf ./uhttpd/build
	rm -rf ./rpcd/build
	rm -rf ./mountd/build
	rm -rf ./jsonpath/build

pull:
	git submodule update --recursive --remote
