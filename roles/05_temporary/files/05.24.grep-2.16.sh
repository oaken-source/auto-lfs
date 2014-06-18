#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf grep-2.16.tar.xz
cd grep-2.16

./configure --prefix=/tools

make

make check

make install

cd ..
rm -rf grep-2.16
