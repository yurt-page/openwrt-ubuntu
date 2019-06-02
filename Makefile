#Standard stuff here
.PHONY: all clean pull install uninstall

MKFILE_PATH:=$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
MKFILE_DIR:=$(shell cd $(shell dirname $(MKFILE_PATH)); pwd)
CURRENT_DIR:=$(notdir $(MKFILE_DIR))
CMAKE_FIND_ROOT_PATH:="${MKFILE_DIR}/"

all: libubox/build ubus/build uci/build ustream-ssl/build uhttpd/build jsonpath/build mountd/build

install: libubox/build ubus/build uci/build ustream-ssl/build uhttpd/build mountd/build jsonpath/build
	cd ./libubox/build; make DESTDIR=$(DESTDIR) install
	cd ./ubus/build; make DESTDIR=$(DESTDIR) install
	cd ./uci/build; make DESTDIR=$(DESTDIR) install
	cd ./ustream-ssl/build; make DESTDIR=$(DESTDIR) install
	cd ./uhttpd/build; make DESTDIR=$(DESTDIR) install
#	cd ./rpcd/build; make DESTDIR=$(DESTDIR) install
	cd ./mountd/build; make DESTDIR=$(DESTDIR) install
	cd ./jsonpath/build; make DESTDIR=$(DESTDIR) install

uninstall:
	cd ./libubox/build; xargs rm < install_manifest.txt
	cd ./ubus/build; xargs rm < install_manifest.txt
	cd ./uci/build; xargs rm < install_manifest.txt
	cd ./ustream-ssl/build; xargs rm < install_manifest.txt
	cd ./uhttpd/build; xargs rm < install_manifest.txt
#	cd ./rpcd/build; xargs rm < install_manifest.txt
	cd ./mountd/build; xargs rm < install_manifest.txt
	cd ./jsonpath/build; xargs rm < install_manifest.txt

libubox/build:
	mkdir ./libubox/build
	cd ./libubox/build; cmake -DCMAKE_INSTALL_PREFIX=${DESTDIR}/usr -DCMAKE_FIND_ROOT_PATH=${CMAKE_FIND_ROOT_PATH} -DLUAPATH=/usr/lib/x86_64-linux-gnu/lua/5.1 -DBUILD_EXAMPLES=OFF .. ; make

ubus/build: libubox/build
	mkdir ./ubus/build
	cd ./ubus/build; cmake -DCMAKE_INSTALL_PREFIX=${DESTDIR}/usr -DCMAKE_FIND_ROOT_PATH=${CMAKE_FIND_ROOT_PATH} -DLUAPATH=/usr/lib/x86_64-linux-gnu/lua/5.1 -DBUILD_EXAMPLES=OFF .. ; make

uci/build: libubox/build
	mkdir ./uci/build
	cd ./uci/build; cmake -DCMAKE_INSTALL_PREFIX=${DESTDIR}/usr -DCMAKE_FIND_ROOT_PATH=${CMAKE_FIND_ROOT_PATH} -DLUAPATH=/usr/lib/x86_64-linux-gnu/lua/5.1 .. ; make

ustream-ssl/build: libubox/build
	mkdir ./ustream-ssl/build
	cd ./ustream-ssl/build; cmake -DCMAKE_INSTALL_PREFIX=${DESTDIR}/usr -DCMAKE_FIND_ROOT_PATH=${CMAKE_FIND_ROOT_PATH} .. ; make

uhttpd/build: libubox/build ustream-ssl/build ubus/build
	mkdir ./uhttpd/build
	cd ./uhttpd/build; cmake -DCMAKE_INSTALL_PREFIX=${DESTDIR}/usr -DCMAKE_FIND_ROOT_PATH=${CMAKE_FIND_ROOT_PATH} .. ; make

rpcd/build: libubox/build ubus/build uci/build
	mkdir ./rpcd/build
	cd ./rpcd/build; cmake -DCMAKE_INSTALL_PREFIX=${DESTDIR}/usr -DCMAKE_FIND_ROOT_PATH=${CMAKE_FIND_ROOT_PATH} -DIWINFO_SUPPORT=OFF .. ; make

mountd/build: libubox/build uci/build
	mkdir ./mountd/build
	cd ./mountd/build; cmake -DCMAKE_INSTALL_PREFIX=${DESTDIR}/usr -DCMAKE_FIND_ROOT_PATH=${CMAKE_FIND_ROOT_PATH} .. ; make

jsonpath/build: libubox/build
	mkdir ./jsonpath/build
	cd ./jsonpath/build; cmake -DCMAKE_INSTALL_PREFIX=${DESTDIR}/usr -DCMAKE_FIND_ROOT_PATH=${CMAKE_FIND_ROOT_PATH} .. ; make

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
