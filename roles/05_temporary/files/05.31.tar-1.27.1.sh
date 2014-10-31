#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/tar-1.27.1.tar.xz
cd tar-1.27.1

./configure --prefix=/tools

make

make check

make install

cd ..
rm -rf tar-1.27.1
