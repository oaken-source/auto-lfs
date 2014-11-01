#!/bin/bash

set +h
set -e
set -u
set -x

/tools/bin/find /{,usr/}{bin,lib,sbin} -type f \
  -exec /tools/bin/strip --strip-debug '{}' ';'
