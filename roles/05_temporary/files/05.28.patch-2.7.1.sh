#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/patch-2.7.1.tar.xz
cd patch-2.7.1

./configure --prefix=/tools

make ${LFS_MFLAGS:-}

make check

make install

cd ..
rm -rf patch-2.7.1
