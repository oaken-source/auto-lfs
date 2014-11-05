#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/coreutils-8.22.tar.xz
cd coreutils-8.22

./configure --prefix=/tools --enable-install-program=hostname

make ${LFS_MFLAGS:-}

make RUN_EXPENSIVE_TESTS=yes check

make install

cd ..
rm -rf coreutils-8.22
