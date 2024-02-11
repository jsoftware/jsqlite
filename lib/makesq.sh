#!/bin/sh

set -e

cd `dirname "$(realpath $0)"`

T=~/temp/sqlite
mkdir -p $T
rm -rf $T/*

if [ "`uname`" = "OpenBSD" ] || [ "`uname`" = "FreeBSD" ]; then
  make=gmake
else
  make="${make:=make}"
fi

cd c && $make clean && $make && \
cd ../cpp && $make clean && $make && \
cp *.so $T/. && cd ..

if [ "`uname`" = "Linux" ] && [ "`uname -m`" = "x86_64" ] ; then

cd c && $make M32=-m32 clean && $make M32=-m32 && \
cd ../cpp && $make M32=-m32 clean && $make M32=-m32 && \
cp *.so $T/. && cd ..

fi

exit 0

