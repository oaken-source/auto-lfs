#!/bin/bash

set +h
set -e
set -u
set -x

echo 7.5 > /etc/lfs-release

cat > /etc/lsb-release << "EOF"
DISTRIB_ID="Linux From Scratch"
DISTRIB_RELEASE="7.5"
DISTRIB_CODENAME="Andreas Grapentin"
DISTRIB_DESCRIPTION="Linux From Scratch"
EOF
