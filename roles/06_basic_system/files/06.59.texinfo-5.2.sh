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

tar -xf texinfo-5.2.tar.xz
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
