#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/xz-5.0.5.tar.xz
cd xz-5.0.5

./configure --prefix=/usr --docdir=/usr/share/doc/xz-5.0.5

make

make check

make install
mv -v /usr/bin/{lzma,unlzma,lzcat,xz,unxz,xzcat} /bin
mv -v /usr/lib/liblzma.so.* /lib
ln -svf ../../lib/$(readlink /usr/lib/liblzma.so) /usr/lib/liblzma.so

cd ..
rm -rf xz-5.0.5
