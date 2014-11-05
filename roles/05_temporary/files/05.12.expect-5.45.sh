#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/expect5.45.tar.gz
cd expect5.45

cp configure{,.orig}
sed 's:/usr/local/bin:/bin:' configure.orig > configure

./configure             \
  --prefix=/tools       \
  --with-tcl=/tools/lib \
  --with-tclinclude=/tools/include

make ${LFS_MFLAGS:-}

# send_tty clutters the output and breaks ansible integration
cp tests/logfile.test{,.orig}
sed 's:send_tty:#send_tty:' tests/logfile.test.orig > tests/logfile.test

make test

make SCRIPTS="" install

cd ..
rm -rf expect5.45
