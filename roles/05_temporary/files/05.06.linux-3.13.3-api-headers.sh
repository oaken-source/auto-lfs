#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/linux-3.13.3.tar.xz
cd linux-3.13.3

make mrproper
make headers_check
make INSTALL_HDR_PATH=dest headers_install
cp -r dest/include/* /tools/include

cd ..
rm -rf linux-3.13.3


