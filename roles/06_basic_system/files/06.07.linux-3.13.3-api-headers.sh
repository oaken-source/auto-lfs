#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/linux-3.13.3.tar.xz
cd linux-3.13.3

make mrproper

make headers_check
make INSTALL_HDR_PATH=dest headers_install
find dest/include \( -name .install -o -name ..install.cmd \) -delete
cp -r dest/include/* /usr/include

cd ..
rm -rf linux-3.13.3
