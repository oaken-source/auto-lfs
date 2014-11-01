#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/util-linux-2.24.1.tar.xz
cd util-linux-2.24.1

sed -i -e 's@etc/adjtime@var/lib/hwclock/adjtime@g' \
  $(grep -rl '/etc/adjtime' .)

mkdir -pv /var/lib/hwclock

./configure

make

chown -Rv nobody .
set +e
su nobody -s /bin/bash -c "PATH=$PATH make -k check"
set -e

make install

cd ..
rm -rf util-linux-2.24.1
