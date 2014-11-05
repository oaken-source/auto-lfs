#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/mpfr-3.1.2.tar.xz
cd mpfr-3.1.2

./configure --prefix=/usr \
  --enable-thread-safe    \
  --docdir=/usr/share/doc/mpfr-3.1.2

make ${LFS_MFLAGS:-}

make check

make install

make html

make install-html

cd ..
rm -rf mpfr-3.1.2
