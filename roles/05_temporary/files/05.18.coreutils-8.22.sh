#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf coreutils-8.22.tar.xz
cd coreutils-8.22

./configure --prefix=/tools --enable-install-program=hostname

make

make RUN_EXPENSIVE_TESTS=yes check

make install

cd ..
rm -rf coreutils-8.22
