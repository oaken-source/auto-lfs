#!/bin/bash

set -e
set -u
set -x

strip --strip-debug /tools/lib/* || true
/usr/bin/strip --strip-unneeded /tools/{,s}bin/* || true

rm -rf /tools/{,share}/{info,man,doc}
