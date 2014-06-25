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

tar -xf gmp-5.1.3.tar.xz
cd gmp-5.1.3

./configure --prefix=/usr --enable-cxx

make

make check 2>&1 | tee gmp-check-log

awk '/tests passed/{total+=$2} ; END{print total}' gmp-check-log

make install

mkdir -v /usr/share/doc/gmp-5.1.3
cp -v doc/{isa_abi_headache,configuration} doc/*.html \
  /usr/share/doc/gmp-5.1.3

cd ..
rm -rf gmp-5.1.3
