#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf xz-5.0.5.tar.xz
cd xz-5.0.5

./configure --prefix=/tools

make

make check

make install

cd ..
rm -rf xz-5.0.5
