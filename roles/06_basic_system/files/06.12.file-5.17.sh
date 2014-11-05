#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/file-5.17.tar.gz
cd file-5.17

./configure --prefix=/usr

make ${LFS_MFLAGS:-}

make check

make install

cd ..
rm -rf file-5.17
