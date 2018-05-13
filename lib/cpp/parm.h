#ifndef PARM_H
#define PARM_H

#include "jsqlite.h"

// ---------------------------------------------------------------------
class Parm
{
public:
  Parm(sqlite3_stmt*, int, int, char*);
  virtual int bind(int) {return 0;};
  char *buf;
  int ndx;
  int rws;
  sqlite3_stmt* sh;
};

// ---------------------------------------------------------------------
class ParmBlob : public Parm
{
public:
  ParmBlob(sqlite3_stmt* sh, int ndx, int rws, char* buf);
  int bind(int);
  char* blb;
  int* len;
};

// ---------------------------------------------------------------------
class ParmFloat : public Parm
{
public:
  ParmFloat(sqlite3_stmt* sh, int ndx, int rws, char* buf) : Parm(sh, ndx, rws, buf) {};
  int bind(int);
};

// ---------------------------------------------------------------------
class ParmInt : public Parm
{
public:
  ParmInt(sqlite3_stmt* sh, int ndx, int rws, char* buf) : Parm(sh, ndx, rws, buf) {};
  int bind(int);
};

// ---------------------------------------------------------------------
class ParmText : public Parm
{
public:
  ParmText(sqlite3_stmt* sh, int ndx, int rws, char* buf) : Parm(sh, ndx, rws, buf) {};
  int bind(int);
};

#endif
