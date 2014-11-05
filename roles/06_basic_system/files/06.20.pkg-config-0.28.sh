#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/pkg-config-0.28.tar.gz
cd pkg-config-0.28

./configure             \
  --prefix=/usr         \
  --with-internal-glib  \
  --disable-host-tool   \
  --docdir=/usr/share/doc/pkg-config-0.28

make ${LFS_MFLAGS:-}

make check

make install

cd ..
rm -rf pkg-config-0.28
