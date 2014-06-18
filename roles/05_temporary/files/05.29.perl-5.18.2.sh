#!/bin/bash

if [ -z "$1" ]; then
  cd $LFS/sources && $0 go &> $LFS/logs/$(basename $0).log
  exit $?
fi

set -e
set -u
set -x

tar -xf perl-5.18.2.tar.bz2
cd perl-5.18.2

patch -Np1 -i ../perl-5.18.2-libc-1.patch

sh Configure -des -Dprefix=/tools

make

cp perl cpan/podlators/pod2man /tools/bin
mkdir -p /tools/lib/perl5/5.18.2
cp -R lib/* /tools/lib/perl5/5.18.2

cd ..
rm -rf perl-5.18.2
