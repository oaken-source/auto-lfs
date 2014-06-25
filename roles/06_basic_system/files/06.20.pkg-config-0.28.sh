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

tar -xf pkg-config-0.28.tar.gz
cd pkg-config-0.28

./configure             \
  --prefix=/usr         \
  --with-internal-glib  \
  --disable-host-tool   \
  --docdir=/usr/share/doc/pkg-config-0.28

make

make check

make install

cd ..
rm -rf pkg-config-0.28
