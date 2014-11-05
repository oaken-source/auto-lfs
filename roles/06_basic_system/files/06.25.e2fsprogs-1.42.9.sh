#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/e2fsprogs-1.42.9.tar.gz
cd e2fsprogs-1.42.9

sed -i -e 's|^LD_LIBRARY_PATH.*|&:/tools/lib|' tests/test_config

mkdir -v build
cd build

LIBS=-L/tools/lib                     \
CFLAGS=-I/tools/include               \
PKG_CONFIG_PATH=/tools/lib/pkgconfig  \
../configure                          \
  --prefix=/usr                       \
  --with-root-prefix=""               \
  --enable-elf-shlibs                 \
  --disable-libblkid                  \
  --disable-libuuid                   \
  --disable-uuidd                     \
  --disable-fsck

make ${LFS_MFLAGS:-}

make check

make install

make install-libs

chmod -v u+w /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a

gunzip -v /usr/share/info/libext2fs.info.gz
install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info

makeinfo -o       doc/com_err.info ../lib/et/com_err.texinfo
install -v -m644  doc/com_err.info /usr/share/info
install-info --dir-file=/usr/share/info/dir /usr/share/info/com_err.info

cd ../..
rm -rf e2fsprogs-1.42.9

