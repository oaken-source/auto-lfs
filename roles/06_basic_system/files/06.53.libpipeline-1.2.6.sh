#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/libpipeline-1.2.6.tar.gz
cd libpipeline-1.2.6

PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr

make ${LFS_MFLAGS:-}

make check

make install

cd ..
rm -rf libpipeline-1.2.6
