#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf make-4.0.tar.bz2
cd make-4.0

./configure --prefix=/tools --without-guile

make

make check

make install

cd ..
rm -rf make-4.0
