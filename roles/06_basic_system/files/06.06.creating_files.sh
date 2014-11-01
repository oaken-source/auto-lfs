#!/bin/bash

set +h
set -e
set -u
set -x

ln -s /tools/bin/{bash,cat,echo,pwd,stty} /bin
ln -s /tools/bin/perl /usr/bin
ln -s /tools/lib/libgcc_s.so{,.1} /usr/lib
ln -s /tools/lib/libstdc++.so{,.6} /usr/lib
sed 's/tools/usr/' /tools/lib/libstdc++.la > /usr/lib/libstdc++.la
ln -s bash /bin/sh

ln -s /proc/self/mounts /etc/mtab

touch /var/log/{btmp,lastlog,wtmp}
chgrp utmp /var/log/lastlog
chmod 664 /var/log/lastlog
chmod 600 /var/log/btmp
