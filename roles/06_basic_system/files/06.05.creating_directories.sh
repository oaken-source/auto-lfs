#!/bin/bash

if [ -z "$1" ]; then
  cp $0 $LFS/
  chroot "$LFS" /tools/bin/env -i                 \
    HOME=/root                                    \
    TERM="$TERM"                                  \
    PS1='\u:\w\$ '                                \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
    /tools/bin/bash --login +h -c "bash /$(basename $0) go" &> $LFS/logs/$(basename $0).log

  rm $LFS/$(basename $0)
  exit $?
fi

set -e
set -u
set -x

mkdir -p /{bin,boot,etc/{opt,sysconfig},home,lib,mnt,opt}
mkdir -p /{media/{floppy,cdrom},sbin,srv,var}
install -d -m 0750 /root
install -d -m 1777 /tmp /var/tmp
mkdir -p /usr/{,local/}{bin,include,lib,sbin,src}
mkdir -p /usr/{,local/}share/{color,dict,doc,info,locale,man}
mkdir -p /usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -p /usr/libexec
mkdir -p /usr/{,local/}share/man/man{1..8}

case $(uname -m) in
  x86_64)   ln -s lib /lib64 
        &&  ln -s lib /usr/lib64 
        &&  ln -s lib /usr/local/lib64 
      ;;
esac

mkdir -p /var/{log,mail,spool}
ln -s /run /var/run
ln -s /run/lock /var/lock
mkdir -p /var/{opt,cache,lib/{color,misc,locate},local}
