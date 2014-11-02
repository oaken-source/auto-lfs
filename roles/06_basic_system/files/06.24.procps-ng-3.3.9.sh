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

# this fixes a race condition in the vmstat test that is already fixed upstream
cp testsuite/vmstat.test/vmstat.exp{,.orig}
sed -r 's:\\\[a-z\\\]\+\\\\d\+:\\[shv\\]d\\[a-z\\]\\\\d\\\\d+:' testsuite/vmstat.test/vmstat.exp.orig > testsuite/vmstat.test/vmstat.exp

make check

make install

mv -v /usr/bin/pidof /bin
mv -v /usr/lib/libprocps.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libprocps.so) /usr/lib/libprocps.so

cd ..
rm -rf procps-ng-3.3.9
