#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/gettext-0.18.3.2.tar.gz
cd gettext-0.18.3.2

./configure --prefix=/usr --docdir=/usr/share/doc/gettext-0.18.3.2

make

make check

make install

cd ..
rm -rf gettext-0.18.3.2
