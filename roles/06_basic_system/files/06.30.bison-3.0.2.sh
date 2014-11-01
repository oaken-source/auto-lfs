#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/bison-3.0.2.tar.xz
cd bison-3.0.2

./configure --prefix=/usr

make

make check

make install

cd ..
rm -rf bison-3.0.2
