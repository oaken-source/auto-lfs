#!/bin/bash

if [ -z "$1" ]; then
  cp $0 $LFS/sources/
  chroot "$LFS" /tools/bin/env -i                 \
    HOME=/root                                    \
    TERM="$TERM"                                  \
    PS1='\u:\w\$ '                                \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
    /tools/bin/bash --login +h -c "cd /sources && bash $(basename $0) go" &> $LFS/logs/$(basename $0).log

  res=$?
  rm $LFS/sources/$(basename $0)
  exit $res
fi

set +h
set -e
set -u
set -x

tar -xf systemd-208.tar.xz
cd systemd-208

tar -xvf ../udev-lfs-208-3.tar.bz2

ln -svf /tools/include/blkid /usr/include
ln -svf /tools/include/uuid /usr/include
export LD_LIBRARY_PATH=/tools/lib

make -f udev-lfs-208-3/Makefile.lfs

make -f udev-lfs-208-3/Makefile.lfs install

build/udevadm hwdb --update

bash udev-lfs-208-3/init-net-rules.sh

rm -fv /usr/include/{uuid,blkid}
unset LD_LIBRARY_PATH

cd ..
rm -rf systemd-208
