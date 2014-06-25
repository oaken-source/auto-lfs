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

tar -xf binutils-2.24.tar.bz2
cd binutils-2.24

expect -c "spawn ls" | grep "spawn ls"

rm -fv etc/standards.info
sed -i.bak '/^INFO/s/standards.info //' etc/Makefile.in

mkdir -v ../binutils-build
cd ../binutils-build

../binutils-2.24/configure --prefix=/usr --enable-shared

make tooldir=/usr

make check

make tooldir=/usr install

cd ..
rm -rf binutils-build
rm -rf binutils-2.24
