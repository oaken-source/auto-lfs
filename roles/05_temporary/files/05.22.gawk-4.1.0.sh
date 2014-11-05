#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/gawk-4.1.0.tar.xz
cd gawk-4.1.0

./configure --prefix=/tools

make ${LFS_MFLAGS:-}

make check

make install

cd ..
rm -rf gawk-4.1.0
