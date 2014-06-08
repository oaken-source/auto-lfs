#!/bin/bash

 # This file is used to prepare the host on which the bootstrapping virtual
 # machine is executed. This is the only script of this project that requries
 # human interaction, everything else is completely automated.
 ############################################################################## 

set -e
set -u

if [ -n "${DEBUG:-}" ]; then
  set -x
fi

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

echo "done."
