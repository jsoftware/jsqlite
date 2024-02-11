# jsqlite makefile
#
# tested with:
#  g++ 5.4.0 20160609 (Linux)
#  clang 703.0.29     (OSX)

UNAME=$(shell uname -s)

ifeq ($(UNAME),FreeBSD)
CC=clang++
endif
ifeq ($(UNAME),OpenBSD)
CC=clang++
endif
ifeq ($(UNAME),Linux)
CC=g++
endif

ifeq ($(UNAME),Darwin)
CC=clang++

ifeq (x$(ARCH),x)
ARCH=x86_64
endif
CFLAGS=-arch $(ARCH) -O2 -fPIC -I. -DSQLITE_THREADSAFE=0 -DSQLITE_OMIT_LOAD_EXTENSION -DSQLITE_ENABLE_COLUMN_METADATA -DSQLITE_ENABLE_FTS5
else
CC=$(CC) $(M32)
CFLAGS=-O2 -fPIC -I. -DSQLITE_THREADSAFE=0 -DSQLITE_OMIT_LOAD_EXTENSION -DSQLITE_ENABLE_COLUMN_METADATA -DSQLITE_ENABLE_FTS5
endif

ifeq ($(UNAME),Darwin)
	TGT=libjsqlite3.dylib
else
ifeq ($(M32),-m32)
	TGT=libjsqlite3_32.so
else
	TGT=libjsqlite3.so
endif
endif

SRC=$(wildcard *.cpp)
OBJ=$(SRC:%.cpp=%.o)

all: $(OBJ)
	$(CC) $(CFLAGS) -shared ../c/sqlite3.o $(OBJ) -o $(TGT)

%.o: %.cpp
	$(CC) -c $(CFLAGS) $^

clean:
	rm -f *.o

