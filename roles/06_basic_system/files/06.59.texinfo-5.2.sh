#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/texinfo-5.2.tar.xz
cd texinfo-5.2

./configure --prefix=/usr

make

make check

make install

make TEXMF=/usr/share/texmf install-tex

# to refresh /usr/shar/info/dir
cd /usr/share/info
rm -v dir
for f in *
do install-info $f dir 2>/dev/null
done

cd ../..
rm -rf texinfo-5.2
