#!/bin/bash


 # This script is the entry to the bootstrapping of LFS. This  script is
 # responsible for setting up the environment inside the virtual machine, e.g.
 # partitioning of the lfs disk, mounting, user management, and calling the
 # build subscript.
 ############################################################################## 

set -e
set -u

if [ -n "${DEBUG:-}" ]; then
  set -x
fi
