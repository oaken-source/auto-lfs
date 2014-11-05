#!/bin/bash

set +x
set -e
set -u
set -x

tar -xf ../sources/linux-3.13.3.tar.xz
cd linux-3.13.3

make mrproper

make defconfig

make ${LFS_MFLAGS:-}

make modules_install

cp -v arch/x86/boot/bzImage /boot/vmlinuz-3.13.3-lfs-7.5
cp -v System.map /boot/System.map-3.13.3
cp -v .config /boot/config-3.13.3

install -d /usr/share/doc/linux-3.13.3
cp -r Documentation/* /usr/share/doc/linux-3.13.3

install -v -m755 -d /etc/modprobe.d
cat > /etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf

install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true

# End /etc/modprobe.d/usb.conf
EOF

cd ..
rm -rf linux-3.13.3
