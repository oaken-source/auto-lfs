#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/gmp-5.1.3.tar.xz
cd gmp-5.1.3

./configure --prefix=/usr --enable-cxx

make ${LFS_MFLAGS:-}

make check 2>&1 | tee gmp-check-log

awk '/tests passed/{total+=$2} ; END{print total}' gmp-check-log

make install

mkdir -v /usr/share/doc/gmp-5.1.3
cp -v doc/{isa_abi_headache,configuration} doc/*.html \
  /usr/share/doc/gmp-5.1.3

cd ..
rm -rf gmp-5.1.3
