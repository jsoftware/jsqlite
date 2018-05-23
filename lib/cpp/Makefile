# jsqlite makefile
#
# tested with:
#  g++ 5.4.0 20160609 (Linux)
#  clang 703.0.29     (OSX)

CC=g++ $(M32)
CFLAGS=-O2 -fPIC -I. -DSQLITE_THREADSAFE=0 -DSQLITE_OMIT_LOAD_EXTENSION -DSQLITE_ENABLE_COLUMN_METADATA

UNAME=$(shell uname -s)

ifeq ($(UNAME),Darwin)
	TGT=libjsqlite3.dylib
else
	TGT=libjsqlite3.so
endif

SRC=$(wildcard *.cpp)
OBJ=$(SRC:%.cpp=%.o)

all: $(OBJ)
	$(CC) -shared ../c/sqlite3.o $(OBJ) -o $(TGT)

%.o: %.cpp
	$(CC) -c $(CFLAGS) $^

clean:
	rm -f *.o *.so
