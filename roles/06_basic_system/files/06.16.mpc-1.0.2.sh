#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/mpc-1.0.2.tar.gz
cd mpc-1.0.2

./configure --prefix=/usr

make ${LFS_MFLAGS:-}

make check

make install

cd ..
rm -rf mpc-1.0.2
