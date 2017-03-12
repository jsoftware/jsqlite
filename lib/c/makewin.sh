# makewin.sh
#
# run on mingw/linux
#
# see ../cpp/makewin.sh for tested compiler

rm -f *.obj

CC=x86_64-w64-mingw32-g++

$CC -c -x c -I. \
  -DSQLITE_THREADSAFE=0 -DSQLITE_OMIT_LOAD_EXTENSION \
  sqlite3.c -o sqlite3.obj
