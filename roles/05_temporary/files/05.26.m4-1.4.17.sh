#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf m4-1.4.17.tar.xz
cd m4-1.4.17

./configure --prefix=/tools

make

make check

make install

cd ..
rm -rf m4-1.4.17
