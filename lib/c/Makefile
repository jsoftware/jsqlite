# sqlite makefile
#
# see ../cpp/Makefile for tested compilers

CC=g++

CFLAGS=-O2 -fPIC -I. \
	-D SQLITE_ENABLE_COLUMN_METADATA=1 \
	-DSQLITE_THREADSAFE=0 -DSQLITE_OMIT_LOAD_EXTENSION

sqlite3.o: sqlite3.c sqlite3.h
	$(CC) -c -x c $(CFLAGS) sqlite3.c -o sqlite3.o

clean:
	rm -f *.o
