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

tar -xf bash-4.2.tar.gz
cd bash-4.2

patch -Np1 -i ../bash-4.2-fixes-12.patch

./configure                         \
  --prefix=/usr                     \
  --bindir=/bin                     \
  --htmldir=/usr/share/doc/bash-4.2 \
  --without-bash-malloc             \
  --with-installed-readline

make

chown -Rv nobody .

su nobody -s /bin/bash -c "PATH=$PATH make tests"

make install

cd ..
rm -rf bash-4.2
