#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/procps-ng-3.3.9.tar.xz
cd procps-ng-3.3.9

./configure                               \
  --prefix=/usr                           \
  --exec-prefix=                          \
  --libdir=/usr/lib                       \
  --docdir=/usr/share/doc/procps-ng-3.3.9 \
  --disable-static                        \
  --disable-kill

make

sed -i -r 's|(pmap_initname)\\\$|\1|' testsuite/pmap.test/pmap.exp
make check

make install

mv -v /usr/bin/pidof /bin
mv -v /usr/lib/libprocps.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libprocps.so) /usr/lib/libprocps.so

cd ..
rm -rf procps-ng-3.3.9
