#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/util-linux-2.24.1.tar.xz
cd util-linux-2.24.1

./configure                       \
  --prefix=/tools                 \
  --disable-makeinstall-chown     \
  --without-systemdsystemunitdir  \
  PKG_CONFIG=""

make ${LFS_MFLAGS:-}

make install

cd ..
rm -rf util-linux-2.24.1
