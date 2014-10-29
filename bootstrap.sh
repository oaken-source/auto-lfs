#!/bin/bash

 # this script is executed by vagrant on the virtual machine after it is
 # started for the first time, and provides an initial bootstrapping for the
 # ansible deployment to build upon.
 # that is, it creates the user that is used for provisioning, and sets the
 # appropriate authentication keys.
 ##############################################################################

set -e
set -u

# server cache update
pacman -Sy

# install python
pacman -S python2 --noconfirm
ln -s /usr/bin/python2 /usr/bin/python

# set up admin user
groupadd admin
useradd -s /bin/bash -g admin -m admin
echo "admin:admin" | chpasswd

# set up access keys
mkdir -p /home/admin/.ssh
chmod 0700 /home/admin/.ssh
pkey="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDT7rxdKquEbWBlpHzsZm1fCOwvqz69xogn8w9H3m0lKGNRRqLUVxZyweV4DAbn2vmLFXrbvR/bCDOZ9TRVHWBgZkXaTPH9Zq8uDcjTGSqEK7sk8/gOh30YoJLkx6mVv7/zM9uySCSXard9k96lPU/VDfdKdn59KHAY/y45/3c73uFpFOjRt/JlY6g6I/PArCuMDOL0DJQ63sFRWkGuZPty44Dsm08LPC6UhZjrtMWBVeZXvfhQkJ6D3cio9Fsuyq6KsJCC/CQcsuQLp0dDENmN4a7S8azSxUuc81HYbYGC+KExowDgUoEXR0bR6Vh6a2552t/BI2HTD08B/hzQ3cET andi@gentoo-maniac"
echo "$pkey" > /home/admin/.ssh/authorized_keys
chmod 0600 /home/admin/.ssh/authorized_keys
chown admin:admin -R /home/admin/.ssh

# install sudo
pacman -S sudo --noconfirm
echo "admin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

