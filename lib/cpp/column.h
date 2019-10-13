#ifndef COLUMN_H
#define COLUMN_H

#include "jsqlite.h"

// ---------------------------------------------------------------------
class Column
{
public:
  Column(sqlite3_stmt *, int);

  virtual char *getbuffer();
  const char *getname() {return name;};
  int getnamelen();
  int gettype() {return type;};
  void initbuffer();
  void pushbuffer();
  virtual void step(int row) {};

  char *buffer;
  vector<char *>buffers;
  vector<I>blobsizes;
  int buflen;
  int len;
  const char *name;
  int ndx;
  int offset;
  int type;
  int wid;
  sqlite3_stmt *sh;
};

// ---------------------------------------------------------------------
class ColBlob : public Column
{
public:
  ColBlob(sqlite3_stmt *, int);
  char *getbuffer();
  void step(int);
  int pos;
};

// ---------------------------------------------------------------------
class ColFloat : public Column
{
public:
  ColFloat(sqlite3_stmt *, int);
  void step(int);
  double *mybuffer;
};

// ---------------------------------------------------------------------
class ColInt : public Column
{
public:
  ColInt(sqlite3_stmt *, int);
  void step(int);
  I *mybuffer;
};

// ---------------------------------------------------------------------
class ColText : public Column
{
public:
  ColText(sqlite3_stmt *, int);
  char *getbuffer();
  void step(int);
  int pos;
};

#endif
