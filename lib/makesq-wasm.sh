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

exit 0

