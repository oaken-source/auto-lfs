#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf diffutils-3.3.tar.xz
cd diffutils-3.3

./configure --prefix=/tools

make

make check

make install

cd ..
rm -rf diffutils-3.3
