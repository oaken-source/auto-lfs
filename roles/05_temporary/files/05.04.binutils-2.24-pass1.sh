#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf binutils-2.24.tar.bz2
cd binutils-2.24

mkdir ../binutils-build
cd ../binutils-build

../binutils-2.24/configure   \
  --prefix=/tools            \
  --with-sysroot=$LFS        \
  --with-lib-path=/tools/lib \
  --target=$LFS_TGT          \
  --disable-nls              \
  --disable-werror             

make

case $(uname -m) in
  x86_64) mkdir -v /tools/lib && ln -sv lib /tools/lib64 ;;
esac

make install

cd ..
rm -rf binutils-build
rm -rf binutils-2.24
