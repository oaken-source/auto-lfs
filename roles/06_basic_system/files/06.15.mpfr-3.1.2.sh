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

tar -xf mpfr-3.1.2.tar.xz
cd mpfr-3.1.2

./configure --prefix=/usr \
  --enable-thread-safe    \
  --docdir=/usr/share/doc/mpfr-3.1.2

make

make check

make install

make html

make install-html

cd ..
rm -rf mpfr-3.1.2
