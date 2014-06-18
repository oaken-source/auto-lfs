#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf texinfo-5.2.tar.xz
cd texinfo-5.2

./configure --prefix=/tools

make

make check

make install

cd ..
rm -rf texinfo-5.2
