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

tar -xf perl-5.18.2.tar.bz2
cd perl-5.18.2

echo "127.0.0.1 localhost $(hostname)" > /etc/hosts

sed -i -e "s|BUILD_ZLIB\s*= True|BUILD_ZLIB = False|"     \
    -e "s|INCLUDE\s*= ./zlib-src|INCLUDE = /usr/include|" \
    -e "s|LIB\s*= ./zlib-src|LIB = /usr/lib|"             \
  cpan/Compress-Raw-Zlib/config.in

sh Configure                    \
  -des -Dprefix=/usr            \
  -Dvendorprefix=/usr           \
  -Dman1dir=/usr/share/man/man1 \
  -Dman3dir=/usr/share/man/man3 \
  -Dpager="/usr/bin/less -isR"  \
  -Duseshrplib

make

make -k test

make install

cd ..
rm -rf perl-5.18.2
