#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/diffutils-3.3.tar.xz
cd diffutils-3.3

./configure --prefix=/tools

make

make check

make install

cd ..
rm -rf diffutils-3.3
