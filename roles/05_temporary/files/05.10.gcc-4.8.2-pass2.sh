#!/bin/bash

set -e
set -u
set -x

tar -xf ../sources/gcc-4.8.2.tar.bz2
cd gcc-4.8.2

cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include-fixed/limits.h

case `uname -m` in
  i?86) sed -i 's/^T_CFLAGS =$/& -fomit-frame-pointer/' gcc/Makefile.in ;;
esac

for file in \
  $(find gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h)
do
  cp -uv $file{,.orig}
  sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
    -e 's@/usr@/tools@g' $file.orig > $file
  echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
  touch $file.orig
done

tar -xf ../../sources/mpfr-3.1.2.tar.xz
mv mpfr-3.1.2 mpfr
tar -xf ../../sources/gmp-5.1.3.tar.xz
mv gmp-5.1.3 gmp
tar -xf ../../sources/mpc-1.0.2.tar.gz
mv mpc-1.0.2 mpc

mkdir ../gcc-build
cd ../gcc-build

CC=$LFS_TGT-gcc                                     \
CXX=$LFS_TGT-g++                                    \
AR=$LFS_TGT-ar                                      \
RANLIB=$LFS_TGT-ranlib                              \
../gcc-4.8.2/configure                              \
  --prefix=/tools                                   \
  --with-local-prefix=/tools                        \
  --with-native-system-header-dir=/tools/include    \
  --enable-clocale=gnu                              \
  --enable-shared                                   \
  --enable-threads=posix                            \
  --enable-__cxa_atexit                             \
  --enable-languages=c,c++                          \
  --disable-libstdcxx-pch                           \
  --disable-multilib                                \
  --disable-bootstrap                               \
  --disable-libgomp                                 \
  --with-mpfr-include=$(pwd)/../gcc-4.8.2/mpfr/src  \
  --with-mpfr-lib=$(pwd)/mpfr/src/.libs

make ${LFS_MFLAGS:-}

make install

ln -s gcc /tools/bin/cc

echo 'main(){}' > dummy.c
cc dummy.c
readelf -l a.out | grep ': /tools' | grep ld-linux.so.2

cd ..
rm -rf gcc-build
rm -rf gcc-4.8.2
