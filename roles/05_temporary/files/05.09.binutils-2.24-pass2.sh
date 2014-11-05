#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/binutils-2.24.tar.bz2
cd binutils-2.24

mkdir ../binutils-build
cd ../binutils-build

CC=$LFS_TGT-gcc               \
AR=$LFS_TGT-ar                \
RANLIB=$LFS_TGT-ranlib        \
../binutils-2.24/configure    \
  --prefix=/tools             \
  --disable-nls               \
  --with-lib-path=/tools/lib  \
  --with-sysroot

make ${LFS_MFLAGS:-}

make install

make -C ld clean
make -C ld LIB_PATH=/usr/lib:/lib
cp ld/ld-new /tools/bin

cd ..
rm -rf binutils-build
rm -rf binutils-2.24
