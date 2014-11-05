#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/tcl8.6.1-src.tar.gz
cd tcl8.6.1

cd unix
./configure --prefix=/tools

make ${LFS_MFLAGS:-}

TZ=UTC make test

make install

chmod u+w /tools/lib/libtcl8.6.so

make install-private-headers

ln -sv tclsh8.6 /tools/bin/tclsh

cd ../..
rm -rf tcl8.6.1
