# makewin.sh
#
# run on mingw/linux
#
# see ../cpp/makewin32.sh for tested compiler

set -e

rm -f sqlite3_32.obj

CC=i686-w64-mingw32-g++

$CC -c -x c -I. \
  -DSQLITE_THREADSAFE=2 -DSQLITE_ENABLE_COLUMN_METADATA -DSQLITE_ENABLE_FTS5 \
  sqlite3.c -o sqlite3_32.obj
