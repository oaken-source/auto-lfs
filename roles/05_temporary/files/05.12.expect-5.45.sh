#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf expect5.45.tar.gz
cd expect5.45

cp configure{,.orig}
sed 's:/usr/local/bin:/bin:' configure.orig > configure

./configure             \
  --prefix=/tools       \
  --with-tcl=/tools/lib \
  --with-tclinclude=/tools/include

make

make test

make SCRIPTS="" install

cd ..
rm -rf expect5.45
