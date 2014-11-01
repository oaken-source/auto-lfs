#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/ncurses-5.9.tar.gz
cd ncurses-5.9

./configure               \
  --prefix=/usr           \
  --mandir=/usr/share/man \
  --with-shared           \
  --without-debug         \
  --enable-pc-files       \
  --enable-widec

make

make install

mv -v /usr/lib/libncursesw.so.5* /lib

ln -sfv ../../lib/$(readlink /usr/lib/libncursesw.so) /usr/lib/libncursesw.so

for lib in ncurses form panel menu ; do
  rm -vf                    /usr/lib/lib${lib}.so
  echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
  ln -sfv lib${lib}w.a      /usr/lib/lib${lib}.a
  ln -sfv ${lib}w.pc        /usr/lib/pkgconfig/${lib}.pc
done

ln -sfv libncurses++w.a /usr/lib/libncurses++.a

rm -vf                      /usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" >  /usr/lib/libcursesw.so
ln -sfv libncurses.so       /usr/lib/libcurses.so
ln -sfv libncursesw.a       /usr/lib/libcursesw.a
ln -sfv libncurses.a        /usr/lib/libcurses.a

mkdir -v        /usr/share/doc/ncurses-5.9
cp -v -R doc/*  /usr/share/doc/ncurses-5.9

cd ..
rm -rf ncurses-5.9
