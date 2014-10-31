#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/gettext-0.18.3.2.tar.gz
cd gettext-0.18.3.2

cd gettext-tools
EMACS="no" ./configure --prefix=/tools --disable-shared

make -C gnulib-lib
make -C src msgfmt
make -C src msgmerge
make -C src xgettext

cp src/{msgfmt,msgmerge,xgettext} /tools/bin

cd ../..
rm -rf gettext-0.18.3.2
