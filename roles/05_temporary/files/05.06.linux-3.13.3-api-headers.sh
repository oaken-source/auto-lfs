#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf linux-3.13.3.tar.xz
cd linux-3.13.3

make mrproper
make headers_check
make INSTALL_HDR_PATH=dest headers_install
cp -r dest/include/* /tools/include

cd ..
rm -rf linux-3.13.3


