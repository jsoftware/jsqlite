#!/bin/sh

mkdir -p ~/vm/d && \
cd c && make clean && make ARCH=x86_64 && \
cd ../cpp && make clean && make ARCH=x86_64 && \
cp libjsqlite3.dylib ~/vm/d/libjsqlite3-x86_64.dylib && cd .. && \
                                 \
cd c && make clean && make ARCH=arm64 && \
cd ../cpp && make clean && make ARCH=arm64 && \
cp libjsqlite3.dylib ~/vm/d/libjsqlite3-arm64.dylib && cd .. && \
                                 \
lipo ~/vm/d/libjsqlite3-x86_64.dylib ~/vm/d/libjsqlite3-arm64.dylib -create -output ~/vm/d/libjsqlite3.dylib && \
rm -f ~/vm/d/libjsqlite3-x86_64.dylib ~/vm/d/libjsqlite3-arm64.dylib
