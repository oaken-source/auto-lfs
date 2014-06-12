#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf dejagnu-1.5.1.tar.gz
cd dejagnu-1.5.1

./configure --prefix=/tools

make install

make check

cd ..
rm -rf dejagnu-1.5.1
