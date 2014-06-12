#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf ncurses-5.9.tar.gz
cd ncurses-5.9

./configure           \
  --prefix=/tools     \
  --with-shared       \
  --without-debug     \
  --without-ada       \
  --enable-widec      \
  --enable-overwrite

make

make install

cd ..
rm -rf ncurses-5.9
