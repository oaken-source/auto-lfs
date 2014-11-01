#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/gzip-1.6.tar.xz
cd gzip-1.6

./configure --prefix=/usr --bindir=/bin

make

make check

make install

mv -v /bin/{gzexe,uncompress,zcmp,zdiff,zegrep} /usr/bin
mv -v /bin/{zfgrep,zforce,zgrep,zless,zmore,znew} /usr/bin

cd ..
rm -rf gzip-1.6
