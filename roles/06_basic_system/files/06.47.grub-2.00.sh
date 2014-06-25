#!/bin/bash

if [ -z "$1" ]; then
  cp $0 $LFS/sources/
  chroot "$LFS" /tools/bin/env -i                 \
    HOME=/root                                    \
    TERM="$TERM"                                  \
    PS1='\u:\w\$ '                                \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
    /tools/bin/bash --login +h -c "cd /sources && bash $(basename $0) go" &> $LFS/logs/$(basename $0).log

  res=$?
  rm $LFS/sources/$(basename $0)
  exit $res
fi

set +h
set -e
set -u
set -x

tar -xf grub-2.00.tar.xz
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
