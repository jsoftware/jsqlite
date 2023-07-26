# makewin.sh
#
# run on mingw/linux
#
# tested with i686-w64-mingw32-g++ (GCC) 6.2.1 20161118

rm -f libjsqlite3_32.dll *.obj

CC=i686-w64-mingw32-g++
TGT=libjsqlite3_32.dll

for f in util colblob colfloat colint coltext column exec jsqlite parm; do
  $CC -c -I. -DSQLITE_THREADSAFE=0 -DSQLITE_OMIT_LOAD_EXTENSION -DSQLITE_ENABLE_COLUMN_METADATA -DSQLITE_ENABLE_FTS5 $f.cpp -o $f.obj;
done

$CC -shared -static-libgcc -static-libstdc++ ../c/sqlite3_32.obj *.obj -o $TGT

cp *.dll ~/vm/d
