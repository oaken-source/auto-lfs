#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf gawk-4.1.0.tar.xz
cd gawk-4.1.0

./configure --prefix=/tools

make

make check

make install

cd ..
rm -rf gawk-4.1.0
