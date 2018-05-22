
#include "column.h"

//#if defined(_WIN64)||defined(__LP64__)
//static I NullInt=0x8000000000000000LL;
//#else
//static I NullInt=0x80000000L;
//#endif

// ---------------------------------------------------------------------
ColInt::ColInt(sqlite3_stmt *sh,int ndx) : Column(sh, ndx)
{
  type=1;
  wid=sizeof(I);
  initbuffer();
  mybuffer=(I *)buffer;
}

// ---------------------------------------------------------------------
void ColInt::step(int row)
{
  int pos=row-offset;
  if (pos==buflen) {
    pushbuffer();
    mybuffer=(I *)buffer;
    pos=row-offset;
  }
  if (SQLITE_NULL==sqlite3_column_type(sh,ndx))
    mybuffer[pos]=NullInt;
  else
#if defined(_WIN64)||defined(__LP64__)
    mybuffer[pos]=sqlite3_column_int64(sh,ndx);
#else
    mybuffer[pos]=sqlite3_column_int(sh,ndx);
#endif
}
