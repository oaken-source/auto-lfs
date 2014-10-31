#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/dejagnu-1.5.1.tar.gz
cd dejagnu-1.5.1

./configure --prefix=/tools

make install

make check

cd ..
rm -rf dejagnu-1.5.1
