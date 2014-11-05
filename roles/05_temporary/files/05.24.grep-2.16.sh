#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/grep-2.16.tar.xz
cd grep-2.16

./configure --prefix=/tools

make ${LFS_MFLAGS:-}

make check

make install

cd ..
rm -rf grep-2.16
