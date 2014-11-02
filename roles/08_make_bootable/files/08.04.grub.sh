#!/bin/bash

set +x
set -e
set -u
set -x

grub-install /dev/sdb

cat > /boot/grub/grub.cfg << "EOF"
# Begin /boot/grub/grub.cfg

set default=0
set timeout=5

insmod ext2
set root=(hd1,3)

menuentry "GNU/Linux, Linux 3.13.3-lfs-7.5" {
  linux /vmlinuz-3.13.3-lfs-7.5 root=/dev/sdb3 ro
}
EOF
