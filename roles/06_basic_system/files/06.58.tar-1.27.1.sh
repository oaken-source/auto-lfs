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

tar -xf tar-1.27.1.tar.xz
cd tar-1.27.1

patch -Np1 -i ../tar-1.27.1-manpage-1.patch

FORCE_UNSAFE_CONFIGURE=1  \
./configure               \
  --prefix=/usr           \
  --bindir=/bin

make

make check

make install
make -C doc install-html docdir=/usr/share/doc/tar-1.27.1

perl tarman > /usr/share/man/man1/tar.1

cd ..
rm -rf tar-1.27.1
