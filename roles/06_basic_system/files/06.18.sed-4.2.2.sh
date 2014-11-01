 #!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/sed-4.2.2.tar.bz2
cd sed-4.2.2

./configure --prefix=/usr --bindir=/bin --htmldir=/usr/share/doc/sed-4.2.2

make

make html

make check

make install

make -C doc install-html

cd ..
rm -rf sed-4.2.2
