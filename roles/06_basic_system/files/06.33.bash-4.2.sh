#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/bash-4.2.tar.gz
cd bash-4.2

patch -Np1 -i ../../sources/bash-4.2-fixes-12.patch

./configure                         \
  --prefix=/usr                     \
  --bindir=/bin                     \
  --htmldir=/usr/share/doc/bash-4.2 \
  --without-bash-malloc             \
  --with-installed-readline

make ${LFS_MFLAGS:-}

chown -Rv nobody .

su nobody -s /bin/bash -c "PATH=$PATH make tests"

make install

cd ..
rm -rf bash-4.2
