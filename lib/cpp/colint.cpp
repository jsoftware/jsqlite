
#include "column.h"

static long long NullInt=0x8000000000000000LL;

// ---------------------------------------------------------------------
ColInt::ColInt(sqlite3_stmt *sh,int ndx) : Column(sh, ndx)
{
  type=1;
  wid=sizeof(long long);
  initbuffer();
  mybuffer=(long long *)buffer;
}

// ---------------------------------------------------------------------
void ColInt::step(int row)
{
  int pos=row-offset;
  if (pos==buflen) {
    pushbuffer();
    mybuffer=(long long *)buffer;
    pos=row-offset;
  }
  if (SQLITE_NULL==sqlite3_column_type(sh,ndx))
    mybuffer[pos]=NullInt;
  else
    mybuffer[pos]=sqlite3_column_int64(sh,ndx);
}
