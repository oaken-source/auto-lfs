#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/findutils-4.4.2.tar.gz
cd findutils-4.4.2

./configure --prefix=/usr --localstatedir=/var/lib/locate

make ${LFS_MFLAGS:-}

make check

make install

mv -v /usr/bin/find /bin
sed -i 's/find:=${BINDIR}/find:=\/bin/' /usr/bin/updatedb

cd ..
rm -rf findutils-4.4.2
