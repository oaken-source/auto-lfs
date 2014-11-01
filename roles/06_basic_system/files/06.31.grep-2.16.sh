#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/grep-2.16.tar.xz
cd grep-2.16

./configure --prefix=/usr --bindir=/bin

make

make check

make install

cd ..
rm -rf grep-2.16
