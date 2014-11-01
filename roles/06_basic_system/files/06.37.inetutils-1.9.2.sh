#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/inetutils-1.9.2.tar.gz
cd inetutils-1.9.2

echo '#define PATH_PROCNET_DEV "/proc/net/dev"' >> ifconfig/system/linux.h

./configure             \
  --prefix=/usr         \
  --localstatedir=/var  \
  --disable-logger      \
  --disable-syslogd     \
  --disable-whois       \
  --disable-servers

make

make check

make install

mv -v /usr/bin/{hostname,ping,ping6,traceroute} /bin
mv -v /usr/bin/ifconfig /sbin

cd ..
rm -rf inetutils-1.9.2
