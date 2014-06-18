#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf bash-4.2.tar.gz
cd bash-4.2

patch -Np1 -i ../bash-4.2-fixes-12.patch

./configure --prefix=/tools --without-bash-malloc

make

make tests

make install

ln -s bash /tools/bin/sh

cd ..
rm -rf bash-4.2
