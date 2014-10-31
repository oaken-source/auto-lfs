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

tar -xf bc-1.06.95.tar.bz2
cd bc-1.06.95

./configure               \
  --prefix=/usr           \
  --with-readline         \
  --mandir=/usr/share/man \
  --infodir=/usr/share/info

make

echo "quit" | ./bc/bc -l Test/checklib.b

make install

cd ..
rm -rf bc-1.06.95