#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/m4-1.4.17.tar.xz
cd m4-1.4.17

./configure --prefix=/usr

make ${LFS_MFLAGS:-}

make check

make install

cd ..
rm -rf m4-1.4.17
