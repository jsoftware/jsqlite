# makewin.sh
#
# run on mingw/linux
#
# see ../cpp/makewin.sh for tested compiler

set -e

rm -f sqlite3.obj

CC=x86_64-w64-mingw32-g++

$CC -c -x c -I. \
  -DSQLITE_THREADSAFE=0 -DSQLITE_OMIT_LOAD_EXTENSION -DSQLITE_ENABLE_COLUMN_METADATA -DSQLITE_ENABLE_FTS5 \
  sqlite3.c -o sqlite3.obj
