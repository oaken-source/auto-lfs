#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/make-4.0.tar.bz2
cd make-4.0

./configure --prefix=/usr

make

make check

make install

cd ..
rm -rf make-4.0
