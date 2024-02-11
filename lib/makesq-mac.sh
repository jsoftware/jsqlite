#!/bin/sh

set -e

# cd `dirname "$(realpath $0)"`

T=~/temp/sqlite
mkdir -p $T
rm -f $T/*

mkdir -p $T && \
cd c && make clean && make ARCH=x86_64 && \
cd ../cpp && make clean && make ARCH=x86_64 && \
cp libjsqlite3.dylib $T/libjsqlite3-x86_64.dylib && cd .. && \
                                 \
cd c && make clean && make ARCH=arm64 && \
cd ../cpp && make clean && make ARCH=arm64 && \
cp libjsqlite3.dylib $T/libjsqlite3-arm64.dylib && cd .. && \
                                 \
lipo $T/libjsqlite3-x86_64.dylib $T/libjsqlite3-arm64.dylib -create -output $T/libjsqlite3.dylib && \
rm -f $T/libjsqlite3-x86_64.dylib $T/libjsqlite3-arm64.dylib

mv $T/libjsqlite3.dylib cpp
