#Standard stuff here
.PHONY:	all clean install uninstall

all:	libubox/build ubus/build ustream-ssl/build uhttpd/build

install:	libubox/build ubus/build ustream-ssl/build uhttpd/build
	cd ./libubox/build; make install
	cd ./ubus/build; make install
	cd ./ustream-ssl/build; make install
	cd ./uhttpd/build; make install

uninstall:
	cd ./libubox/build; xargs rm < install_manifest.txt
	cd ./ubus/build; xargs rm < install_manifest.txt
	cd ./ustream-ssl/build; xargs rm < install_manifest.txt
	cd ./uhttpd/build; xargs rm < install_manifest.txt

libubox/build:
	mkdir ./libubox/build
	cd ./libubox/build; cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_EXAMPLES=OFF .. ; make

ubus/build:	libubox/build
	mkdir ./ubus/build
	cd ./ubus/build; cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_EXAMPLES=OFF  .. ; make

ustream-ssl/build:	libubox/build
	mkdir ./ustream-ssl/build
	cd ./ustream-ssl/build; cmake -DCMAKE_INSTALL_PREFIX=/usr .. ; make

uhttpd/build:	libubox/build ustream-ssl/build ubus/build
	mkdir ./uhttpd/build
	cd ./uhttpd/build; cmake -DCMAKE_INSTALL_PREFIX=/usr .. ; make

clean:
	rm -rf ./libubox/build
	rm -rf ./ubus/build
	rm -rf ./ustream-ssl/build
	rm -rf ./uhttpd/build

