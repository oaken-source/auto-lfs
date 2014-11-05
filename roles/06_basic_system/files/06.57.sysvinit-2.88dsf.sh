#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/sysvinit-2.88dsf.tar.bz2
cd sysvinit-2.88dsf

patch -Np1 -i ../../sources/sysvinit-2.88dsf-consolidated-1.patch

make -C src ${LFS_MFLAGS:-}

make -C src install

cd ..
rm -rf sysvinit-2.88dsf
