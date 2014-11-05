#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/iproute2-3.12.0.tar.xz
cd iproute2-3.12.0

sed -i '/^TARGETS/s@arpd@@g' misc/Makefile
sed -i /ARPD/d Makefile
sed -i 's/arpd.8//' man/man8/Makefile

make DESTDIR= ${LFS_MFLAGS:-}

make DESTDIR=           \
  MANDIR=/usr/share/man \
  DOCDIR=/usr/share/doc/iproute2-3.12.0 install

cd ..
rm -rf iproute2-3.12.0
