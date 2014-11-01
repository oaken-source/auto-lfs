#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/iana-etc-2.30.tar.bz2
cd iana-etc-2.30

make

make install

cd ..
rm -rf iana-etc-2.30
