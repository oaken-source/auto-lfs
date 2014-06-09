#!/bin/bash

 # this script is executed by vagrant on the virtual machine after it is 
 # started for the first time, and provides an initial bootstrapping for the
 # ansible deployment to build upon.
 # that is, it creates the user that is used for provisioning, and sets the
 # appropriate authentication keys.
 ############################################################################## 

set -e
set -u

# set up ansible provisioning user
groupadd provision
useradd -s /bin/bash -g provision -m provision
usermod -aG admin provision
echo 'provision:provision' | chpasswd

mkdir -p /home/provision/.ssh

cp /vagrant/files/id_rsa* /home/provision/.ssh/
cp /vagrant/files/id_rsa.pub /home/provision/.ssh/authorized_keys
chown -R provision:provision /home/provision/.ssh 
chmod 0600 /home/provision/.ssh/id_rsa

