#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/check-0.9.12.tar.gz
cd check-0.9.12

PKG_CONFIG= ./configure --prefix=/tools

make ${LFS_MFLAGS:-}

make check

make install

cd ..
rm -rf check-0.9.12
