#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf patch-2.7.1.tar.xz
cd patch-2.7.1

./configure --prefix=/tools

make

make check

make install

cd ..
rm -rf patch-2.7.1
