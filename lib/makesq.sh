#!/bin/sh

cd `dirname "$(realpath $0)"`

T=~/temp/sqlite
mkdir -p $T
rm -rf $T/*

cd c && make clean && make && \
cd ../cpp && make clean && make && \
cp *.so $T/. && cd ..

cd c && make M32=-m32 clean && make M32=-m32 && \
cd ../cpp && make M32=-m32 clean && make M32=-m32 && \
cp *.so $T/. && cd ..

exit 0

cd c && ./makewin.sh && \
cd ../cpp && ./makewin.sh && \
cd ..

cd c && ./makewin32.sh && \
cd ../cpp && ./makewin32.sh && \
cd ..
