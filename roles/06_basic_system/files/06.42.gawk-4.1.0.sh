#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/gawk-4.1.0.tar.xz
cd gawk-4.1.0

./configure --prefix=/usr

make

make check

make install

mkdir -v /usr/share/doc/gawk-4.1.0
cp -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/gawk-4.1.0

cd ..
rm -rf gawk-4.1.0
