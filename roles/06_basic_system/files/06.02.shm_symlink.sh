#!/bin/bash

set -e
set -u

if [ -h $LFS/dev/shm ]; then
  if [ ! -d $LFS/$(readlink $LFS/dev/shm) ]; then
    mkdir -p $LFS/$(readlink $LFS/dev/shm)
    echo "changed"
  fi
fi
