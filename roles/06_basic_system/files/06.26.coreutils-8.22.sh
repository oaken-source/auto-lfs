#!/bin/bash

set +h
set -e
set -u
set -x

tar -xf ../sources/coreutils-8.22.tar.xz
cd coreutils-8.22

patch -Np1 -i ../../sources/coreutils-8.22-i18n-4.patch

FORCE_UNSAFE_CONFIGURE=1 ./configure  \
  --prefix=/usr                       \
  --enable-no-install-program=kill,uptime

make

make NON_ROOT_USERNAME=nobody check-root

echo "dummy:x:1000:nobody" >> /etc/group

chown -Rv nobody .

su nobody -s /bin/bash \
  -c "PATH=$PATH make RUN_EXPENSIVE_TESTS=yes check"

sed -i '/dummy/d' /etc/group

make install

mv -v /usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} /bin
mv -v /usr/bin/{false,ln,ls,mkdir,mknod,mv,pwd,rm} /bin
mv -v /usr/bin/{rmdir,stty,sync,true,uname,test,[} /bin
mv -v /usr/bin/chroot /usr/sbin
mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
sed -i s/\"1\"/\"8\"/1 /usr/share/man/man8/chroot.8

mv -v /usr/bin/{head,sleep,nice} /bin

cd ..
rm -rf coreutils-8.22
