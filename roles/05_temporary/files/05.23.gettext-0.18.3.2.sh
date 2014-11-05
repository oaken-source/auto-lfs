#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/gettext-0.18.3.2.tar.gz
cd gettext-0.18.3.2

cd gettext-tools
EMACS="no" ./configure --prefix=/tools --disable-shared

make -C gnulib-lib ${LFS_MFLAGS:-}
make -C src msgfmt ${LFS_MFLAGS:-}
make -C src msgmerge ${LFS_MFLAGS:-}
make -C src xgettext ${LFS_MFLAGS:-}

cp src/{msgfmt,msgmerge,xgettext} /tools/bin

cd ../..
rm -rf gettext-0.18.3.2
