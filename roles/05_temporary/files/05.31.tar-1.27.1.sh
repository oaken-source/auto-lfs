#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf tar-1.27.1.tar.xz
cd tar-1.27.1

./configure --prefix=/tools

make

make check

make install

cd ..
rm -rf tar-1.27.1
