#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf findutils-4.4.2.tar.gz
cd findutils-4.4.2

./configure --prefix=/tools

make

make check

make install

cd ..
rm -rf findutils-4.4.2
