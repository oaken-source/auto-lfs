#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf gzip-1.6.tar.xz
cd gzip-1.6

./configure --prefix=/tools

make

make check

make install

cd ..
rm -rf gzip-1.6
