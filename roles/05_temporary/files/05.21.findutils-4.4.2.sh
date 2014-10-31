#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/findutils-4.4.2.tar.gz
cd findutils-4.4.2

./configure --prefix=/tools

make

make check

make install

cd ..
rm -rf findutils-4.4.2
