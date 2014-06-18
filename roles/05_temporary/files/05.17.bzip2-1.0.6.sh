#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf bzip2-1.0.6.tar.gz
cd bzip2-1.0.6

make

make PREFIX=/tools install

cd ..
rm -rf bzip2-1.0.6
