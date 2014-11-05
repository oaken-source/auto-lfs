#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/man-db-2.6.6.tar.xz
cd man-db-2.6.6

./configure                             \
  --prefix=/usr                         \
  --docdir=/usr/share/doc/man-db-2.6.6  \
  --sysconfdir=/etc                     \
  --disable-setuid                      \
  --with-browser=/usr/bin/lynx          \
  --with-vgrind=/usr/bin/vgrind         \
  --with-grap=/usr/bin/grap

make ${LFS_MFLAGS:-}

make check

make install

cd ..
rm -rf man-db-2.6.6

