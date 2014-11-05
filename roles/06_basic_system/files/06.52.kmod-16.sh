#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/kmod-16.tar.xz
cd kmod-16

./configure               \
  --prefix=/usr           \
  --bindir=/bin           \
  --sysconfdir=/etc       \
  --with-rootlibdir=/lib  \
  --disable-manpages      \
  --with-xz               \
  --with-zlib

make ${LFS_MFLAGS:-}

make check

make install
make -C man install

for target in depmod insmod modinfo modprobe rmmod; do
  ln -sv ../bin/kmod /sbin/$target
done

ln -sv kmod /bin/lsmod

cd ..
rm -rf kmod-16
