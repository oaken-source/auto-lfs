#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/gzip-1.6.tar.xz
cd gzip-1.6

./configure --prefix=/tools

make ${LFS_MFLAGS:-}

make check

make install

cd ..
rm -rf gzip-1.6
