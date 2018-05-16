
#include "parm.h"
#include "jsqlite.h"

// ---------------------------------------------------------------------
Parm::Parm(sqlite3_stmt* sh, int ndx, int rws, char* buf)
{
  this->sh=sh;
  this->ndx=ndx;
  this->rws=rws;
  this->buf=buf;
}

// ---------------------------------------------------------------------
ParmBlob::ParmBlob(sqlite3_stmt* sh, int ndx, int rws, char* buf) : Parm(sh, ndx, rws, buf)
{
  len=(int*) buf;
  blb=buf+rws*sizeof(int);
};

// ---------------------------------------------------------------------
int ParmBlob::bind(int i)
{
  int r=sqlite3_bind_blob(sh,ndx,(const void*)blb,len[i],SQLITE_STATIC);
  blb += len[i];
  return r;
}

// ---------------------------------------------------------------------
int ParmFloat::bind(int i)
{
  return sqlite3_bind_double(sh,ndx,((double*)buf)[i]);
}

// ---------------------------------------------------------------------
int ParmInt::bind(int i)
{
#if defined(_WIN64)||defined(__LP64__)
  return sqlite3_bind_int64(sh,ndx,((sqlite3_int64*)buf)[i]);
#else
  return sqlite3_bind_int(sh,ndx,((int*)buf)[i]);
#endif
}

// ---------------------------------------------------------------------
int ParmText::bind(int i)
{
  int n=(int)strlen(buf);
  int r=sqlite3_bind_text(sh,ndx,(const char*)buf,n,SQLITE_STATIC);
  buf += n+1;
  return r;
}
