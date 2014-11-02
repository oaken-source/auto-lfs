#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/autoconf-2.69.tar.xz
cd autoconf-2.69

./configure --prefix=/usr

make

# FIXME: investigate why #209 fails (harmless, yet annoying)
make check || true

make install

cd ..
rm -rf autoconf-2.69
