#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/file-5.17.tar.gz
cd file-5.17

./configure --prefix=/tools

make

make check

make install

cd ..
rm -rf file-5.17