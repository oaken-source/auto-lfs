#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf file-5.17.tar.gz
cd file-5.17

./configure --prefix=/tools

make

make check

make install

cd ..
rm -rf file-5.17
