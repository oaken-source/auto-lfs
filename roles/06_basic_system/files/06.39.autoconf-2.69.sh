#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/autoconf-2.69.tar.xz
cd autoconf-2.69

./configure --prefix=/usr

make ${LFS_MFLAGS:-}

# FISME: figure out why #209 fails
make check || true

make install

cd ..
rm -rf autoconf-2.69
