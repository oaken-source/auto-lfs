#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/shadow_4.1.5.1.orig.tar.gz
cd shadow-4.1.5.1

sed -i 's/groups$(EXEEXT) //' src/Makefile.in
find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;

sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' \
       -e 's@/var/spool/mail@/var/mail@' etc/login.defs

./configure --sysconfdir=/etc

make ${LFS_MFLAGS:-}

make install

mv -v /usr/bin/passwd /bin

pwconv

grpconv

echo "root:pass" | chpasswd

cd ..
rm -rf shadow-4.1.5.1
