#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/tar-1.27.1.tar.xz
cd tar-1.27.1

patch -Np1 -i ../../sources/tar-1.27.1-manpage-1.patch

FORCE_UNSAFE_CONFIGURE=1  \
./configure               \
  --prefix=/usr           \
  --bindir=/bin

make ${LFS_MFLAGS:-}

make check

make install
make -C doc install-html docdir=/usr/share/doc/tar-1.27.1

perl tarman > /usr/share/man/man1/tar.1

cd ..
rm -rf tar-1.27.1
