#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf check-0.9.12.tar.gz
cd check-0.9.12

PKG_CONFIG= ./configure --prefix=/tools

make

make check

make install

cd ..
rm -rf check-0.9.12
