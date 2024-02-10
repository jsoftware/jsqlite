#!/bin/sh
#
# build linux/macOS on github actions
#
# argument is linux|darwin|raspberry|android|openbsd|freebsd|wasm
# wasm is experimental

set -e
CC=${CC-clang}
export CC

mkdir -p $HOME/temp

if [ "$1" = "linux" ]; then
  ext="so"
elif [ "$1" = "raspberry" ]; then
  ext="so"
elif [ "$1" = "darwin" ]; then
  ext="dylib"
elif [ "$1" = "android" ]; then
  ext="so"
elif [ "$1" = "openbsd" ]; then
  ext="so"
elif [ "$1" = "freebsd" ]; then
  ext="so"
elif [ "$1" = "wasm" ]; then
  ext=""
else
  echo "argument is linux|darwin|raspberry|android|openbsd|freebsd|wasm"
  exit 1
fi
uname -a
uname -m
if [ "`uname -m`" != "armv6l" ] && [ "`uname -m`" != "i386" ] && [ "`uname -m`" != "i686" ] ; then
if [ "$1" = "wasm" ]; then
 m64=0
else
 m64=1
fi
else
 m64=0
fi

if [ $m64 -eq 1 ]; then
mkdir -p j64
else
mkdir -p j32
fi

if [ "x$MAKEFLAGS" = x'' ] ; then
if [ "$1" = "wasm" ] ; then
par=2
elif [ "$1" = "linux" ] || [ "$1" = "raspberry" ] ; then
par=`nproc` 
elif [ "$1" = "darwin" ] || [ "$1" = "openbsd" ] || [ "$1" = "freebsd" ] || [ "$1" = "android" ] ; then
par=`sysctl -n hw.ncpu` 
else 
par=2
fi
export MAKEFLAGS=-j$par
fi
echo "MAKEFLAGS=$MAKEFLAGS"

if [ "$1" = "android" ]; then
cd android/jni
ln -sf ../../lib .
cd ../..
rm -f androidlibs.zip
# build binary for armeabi-v7a x86 x86_64 arm64-v8a
cd android
ndk-build
zip -r ../androidlibs.zip libs
cd ..
exit 0
fi

if [ "$1" = "wasm" ]; then
cd lib
./clean.sh
USE_WASM=1 CC=emcc AR=emar ./makesq-wasm.sh
cd ..
cp bin/$1/j32/* j32
find j32 -type d -exec chmod 755 {} \;
find j32 -type f -exec chmod 644 {} \;
ls -l j32
exit 0
fi

cd lib

if [ $m64 -eq 1 ]; then
if [ "$1" = "darwin" ]; then
./clean.sh
./makesq-mac.sh
elif [ "$1" = "linux" ]; then
./clean.sh
./makesq.sh
fi
./clean.sh
if ( [ "$1" = "openbsd" ] || [ "$1" = "freebsd" ] ) && ( [ "`uname -m`" = "aarch64" ] || [ "`uname -m`" = "arm64" ] ) ; then
 ./makesq.sh
else
 ./makesq.sh
fi
else
./makesq.sh
fi

cd -

if [ $m64 -eq 1 ]; then
if ( [ "$1" = "openbsd" ] || [ "$1" = "freebsd" ] ) && ( [ "`uname -m`" = "aarch64" ] || [ "`uname -m`" = "arm64" ] ) ; then
cp lib/cpp/libjsqlite3.so j64
else
cp lib/cpp/libjsqlite3.so j64
fi
else
cp lib/cpp/libjsqlite3.so j32
fi

if [ -d "bin/$1/j64iphoneos" ]; then
mkdir -p j64/ios
cp lib/cpp/libjsqlite3.dylib j64/ios/.
fi

if [ -d "bin/$1/j64iphonesimulator" ]; then
mkdir -p j64/ios
cp lib/cpp/libjsqlite3.dylib j64/ios/.
fi

if [ "$1" = "linux" ]; then
mkdir -p j32
cp lib/cpp/libjsqlite3.so j32
fi

if [ -d j64 ]; then
find j64 -type d -exec chmod 755 {} \;
find j64 -type f -exec chmod 644 {} \;
ls -l j64
fi

if [ -d j32 ]; then
find j32 -type d -exec chmod 755 {} \;
find j32 -type f -exec chmod 644 {} \;
ls -l j32
fi
