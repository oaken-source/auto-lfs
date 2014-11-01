#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/groff-1.22.2.tar.gz
cd groff-1.22.2

PAGE=A4 ./configure --prefix=/usr

make

make install

ln -sv eqn /usr/bin/geqn
ln -sv tbl /usr/bin/gtbl

cd ..
rm -rf groff-1.22.2
