#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/sed-4.2.2.tar.bz2
cd sed-4.2.2

./configure --prefix=/tools

make

make check

make install

cd ..
rm -rf sed-4.2.2
