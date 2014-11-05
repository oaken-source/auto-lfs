#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/psmisc-22.20.tar.gz
cd psmisc-22.20

./configure --prefix=/usr

make ${LFS_MFLAGS:-}

make install

mv -v /usr/bin/fuser    /bin
mv -v /usr/bin/killall  /bin

cd ..
rm -rf psmisc-22.20
