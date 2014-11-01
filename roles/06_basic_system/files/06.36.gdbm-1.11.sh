#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/gdbm-1.11.tar.gz
cd gdbm-1.11

./configure --prefix=/usr --enable-libgdbm-compat

make

make check

make install

cd ..
rm -rf gdbm-1.11
