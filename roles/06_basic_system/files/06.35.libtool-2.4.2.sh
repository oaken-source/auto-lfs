#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/libtool-2.4.2.tar.gz
cd libtool-2.4.2

./configure --prefix=/usr

make ${LFS_MFLAGS:-}

make check

make install

cd ..
rm -rf libtool-2.4.2
