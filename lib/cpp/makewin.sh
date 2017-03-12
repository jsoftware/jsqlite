# makewin.sh
#
# run on mingw/linux
#
# tested with x86_64-w64-mingw32-g++ (GCC) 5.3.1 20160211

rm -f *.dll *.obj

CC=x86_64-w64-mingw32-g++
TGT=libjsqlite3.dll

for f in util colblob colfloat colint coltext column jsqlite; do
  $CC -c -I. -DSQLITE_THREADSAFE=0 -DSQLITE_OMIT_LOAD_EXTENSION $f.cpp -o $f.obj;
done

$CC -shared -static-libgcc -static-libstdc++ ../c/sqlite3.obj *.obj -o $TGT

cp *.dll ~/vm/d
