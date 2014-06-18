#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf sed-4.2.2.tar.bz2
cd sed-4.2.2

./configure --prefix=/tools

make

make check

make install

cd ..
rm -rf sed-4.2.2
