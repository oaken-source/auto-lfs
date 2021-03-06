#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/gcc-4.8.2.tar.bz2
cd gcc-4.8.2

mkdir -p ../gcc-build
cd ../gcc-build

../gcc-4.8.2/libstdc++-v3/configure \
  --host=$LFS_TGT                   \
  --prefix=/tools                   \
  --disable-multilib                \
  --disable-shared                  \
  --disable-nls                     \
  --disable-libstdcxx-threads       \
  --disable-libstdcxx-pch           \
--with-gxx-include-dir=/tools/$LFS_TGT/include/c++/4.8.2

make ${LFS_MFLAGS:-}

make install

cd ..
rm -rf gcc-build
rm -rf gcc-4.8.2
