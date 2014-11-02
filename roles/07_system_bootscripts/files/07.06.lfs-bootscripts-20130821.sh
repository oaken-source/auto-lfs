#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/lfs-bootscripts-20130821.tar.bz2
cd lfs-bootscripts-20130821

make install

cd ..
rm -rf lfs-bootscripts-20130821
