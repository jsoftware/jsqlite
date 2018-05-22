
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
  int r;
  if (len[i]==strlen(NullText) && 0==strncmp(blb,NullText,len[i]))
    r=sqlite3_bind_null(sh,ndx);
  else
    r=sqlite3_bind_blob(sh,ndx,(const void*)blb,len[i],SQLITE_STATIC);
  blb += len[i];
  return r;
}

// ---------------------------------------------------------------------
int ParmFloat::bind(int i)
{
  double d=((double*)buf)[i];
  if (d==NullFloat)
    return sqlite3_bind_null(sh,ndx);
  else
    return sqlite3_bind_double(sh,ndx,d);
}

// ---------------------------------------------------------------------
int ParmInt::bind(int i)
{
#if defined(_WIN64)||defined(__LP64__)
  sqlite3_int64 n=((sqlite3_int64*)buf)[i];
  if (n==NullInt)
    return sqlite3_bind_null(sh,ndx);
  else
    return sqlite3_bind_int64(sh,ndx,n);
#else
  I n=((I*)buf)[i];
  if (n==NullInt)
    return sqlite3_bind_null(sh,ndx);
  else
    return sqlite3_bind_int(sh,ndx,n);
#endif
}

// ---------------------------------------------------------------------
int ParmText::bind(int i)
{
  int r;
  int n=(int)strlen(buf);
  if (0==strcmp(buf,NullText))
    r=sqlite3_bind_null(sh,ndx);
  else
    r=sqlite3_bind_text(sh,ndx,(const char*)buf,n,SQLITE_STATIC);
  buf += n+1;
  return r;
}
