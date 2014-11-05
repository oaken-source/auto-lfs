#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/less-458.tar.gz
cd less-458

./configure --prefix=/usr --sysconfdir=/etc

make ${LFS_MFLAGS:-}

make install

cd ..
rm -rf less-458
