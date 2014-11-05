#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/diffutils-3.3.tar.xz
cd diffutils-3.3

sed -i 's:= @mkdir_p@:= /bin/mkdir -p:' po/Makefile.in.in

./configure --prefix=/usr

make ${LFS_MFLAGS:-}

make check

make install

cd ..
rm -rf diffutils-3.3
