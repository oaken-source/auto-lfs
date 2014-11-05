#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/bzip2-1.0.6.tar.gz
cd bzip2-1.0.6

make ${LFS_MFLAGS:-}

make PREFIX=/tools install

cd ..
rm -rf bzip2-1.0.6
