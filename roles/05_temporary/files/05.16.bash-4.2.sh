#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/bash-4.2.tar.gz
cd bash-4.2

patch -Np1 -i ../../sources/bash-4.2-fixes-12.patch

./configure --prefix=/tools --without-bash-malloc

make

make tests

make install

ln -s bash /tools/bin/sh

cd ..
rm -rf bash-4.2
