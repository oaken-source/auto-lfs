#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/man-pages-3.59.tar.xz
cd man-pages-3.59

make install

cd ..
rm -rf man-pages-3.59
