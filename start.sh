#!/bin/bash

 # this script is the entry to auto-lfs. It checks for required host 
 # capabilities and initiates the auto build
 ############################################################################## 


set -e
set -u

if [ -n "${DEBUG:-}" ]; then
  set -x
fi

# start fresh, if -c was given
while getopts ":c" opt; do
  case $opt in
    c)
      vagrant destroy -f
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

# fetch LFS book
vers=7.5
book=LFS-BOOK-${vers}.pdf
if [ ! -f $book ]; then
  echo " [*] fetching $book"
  wget -q http://www.linuxfromscratch.org/lfs/downloads/$vers/$book
fi

# check for vagrant installation
if ! vagrant --help > /dev/null; then
  echo " [!] missing vagrant. install vagrant and continue"
  exit 1
fi

# check for ansible installation
if ! ansible-playbook --version > /dev/null; then
  echo " [!] missing ansible. install ansible and continue"
  exit 1
fi

vagrant up

while ! ssh -i files/id_rsa -q provision@192.168.22.22 exit; do
  sleep 1
done

if [ -n "${DEBUG:-}" ]; then
  verbose="-vvv"
fi

ansible-playbook -i inventory site.yml ${verbose:-} --private-key files/id_rsa
