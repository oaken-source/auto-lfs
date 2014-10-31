#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/texinfo-5.2.tar.xz
cd texinfo-5.2

./configure --prefix=/tools

make

make check

make install

cd ..
rm -rf texinfo-5.2
