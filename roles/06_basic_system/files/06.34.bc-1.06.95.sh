#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/bc-1.06.95.tar.bz2
cd bc-1.06.95

./configure               \
  --prefix=/usr           \
  --with-readline         \
  --mandir=/usr/share/man \
  --infodir=/usr/share/info

make ${LFS_MFLAGS:-}

echo "quit" | ./bc/bc -l Test/checklib.b

make install

cd ..
rm -rf bc-1.06.95
