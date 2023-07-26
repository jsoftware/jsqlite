# sqlite makefile
#
# see ../cpp/Makefile for tested compilers

UNAME=$(shell uname -s)

ifeq ($(UNAME),Darwin)
CC=clang

ifeq (x$(ARCH),x)
ARCH=$(shell arch)
endif
CFLAGS=-arch $(ARCH) -O2 -fPIC -I. \
	-D SQLITE_ENABLE_COLUMN_METADATA=1 \
	-DSQLITE_THREADSAFE=0 -DSQLITE_OMIT_LOAD_EXTENSION -DSQLITE_ENABLE_FTS5
else
CC=g++ $(M32)

CFLAGS=-O2 -fPIC -I. \
	-D SQLITE_ENABLE_COLUMN_METADATA=1 \
	-DSQLITE_THREADSAFE=0 -DSQLITE_OMIT_LOAD_EXTENSION -DSQLITE_ENABLE_FTS5
endif

sqlite3.o: sqlite3.c sqlite3.h
	$(CC) -c -x c $(CFLAGS) sqlite3.c -o sqlite3.o

clean:
	rm -f *.o
