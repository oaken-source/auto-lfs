#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf util-linux-2.24.1.tar.xz
cd util-linux-2.24.1

./configure                       \
  --prefix=/tools                 \
  --disable-makeinstall-chown     \
  --without-systemdsystemunitdir  \
  PKG_CONFIG=""

make

make install

cd ..
rm -rf util-linux-2.24.1
