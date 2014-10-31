#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/ncurses-5.9.tar.gz
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
