#Standard stuff here
.PHONY: all clean pull install uninstall

all: pull libubox/build ubus/build uci/build ustream-ssl/build uhttpd/build

install: libubox/build ubus/build ustream-ssl/build uhttpd/build
	echo "Makefile: DESTDIR is ${DESTDIR} and CURDIR is ${CURDIR}"
	cd ./libubox/build; make DESTDIR=$(DESTDIR) install
	cd ./ubus/build; make DESTDIR=$(DESTDIR) install
	cd ./uci/build; make DESTDIR=$(DESTDIR) install
	cd ./ustream-ssl/build; make DESTDIR=$(DESTDIR) install
	cd ./uhttpd/build; make DESTDIR=$(DESTDIR) install

uninstall:
	cd ./libubox/build; xargs rm < install_manifest.txt
	cd ./ubus/build; xargs rm < install_manifest.txt
	cd ./uci/build; xargs rm < install_manifest.txt
	cd ./ustream-ssl/build; xargs rm < install_manifest.txt
	cd ./uhttpd/build; xargs rm < install_manifest.txt

libubox/build:
	mkdir ./libubox/build
	cd ./libubox/build; cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_EXAMPLES=OFF .. ; make

ubus/build: libubox/build
	mkdir ./ubus/build
	cd ./ubus/build; cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_EXAMPLES=OFF  .. ; make

uci/build: libubox/build
	mkdir ./uci/build
	cd ./uci/build; cmake -DCMAKE_INSTALL_PREFIX=/usr .. ; make

ustream-ssl/build: libubox/build
	mkdir ./ustream-ssl/build
	cd ./ustream-ssl/build; cmake -DCMAKE_INSTALL_PREFIX=/usr .. ; make

uhttpd/build: libubox/build ustream-ssl/build ubus/build
	mkdir ./uhttpd/build
	cd ./uhttpd/build; cmake -DCMAKE_INSTALL_PREFIX=/usr .. ; make

clean:
	rm -rf ./libubox/build
	rm -rf ./ubus/build
	rm -rf ./uci/build
	rm -rf ./ustream-ssl/build
	rm -rf ./uhttpd/build

pull:
	git submodule update --recursive --remote
