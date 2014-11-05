#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/xz-5.0.5.tar.xz
cd xz-5.0.5

./configure --prefix=/tools

make ${LFS_MFLAGS:-}

make check

make install

cd ..
rm -rf xz-5.0.5
