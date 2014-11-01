#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/binutils-2.24.tar.bz2
cd binutils-2.24

expect -c "spawn ls" | grep "spawn ls"

rm -fv etc/standards.info
sed -i.bak '/^INFO/s/standards.info //' etc/Makefile.in

mkdir -v ../binutils-build
cd ../binutils-build

../binutils-2.24/configure --prefix=/usr --enable-shared

make tooldir=/usr

make check

make tooldir=/usr install

cd ..
rm -rf binutils-build
rm -rf binutils-2.24
