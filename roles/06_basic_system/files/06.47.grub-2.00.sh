#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/grub-2.00.tar.xz
cd grub-2.00

sed -i -e '/gets is a/d' grub-core/gnulib/stdio.in.h

./configure               \
  --prefix=/usr           \
  --sbindir=/sbin         \
  --sysconfdir=/etc       \
  --disable-grub-emu-usb  \
  --disable-efiemu        \
  --disable-werror

make

make install

cd ..
rm -rf grub-2.00
