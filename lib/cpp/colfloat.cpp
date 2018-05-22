
#include "column.h"

// ---------------------------------------------------------------------
ColFloat::ColFloat(sqlite3_stmt * sh, int ndx) : Column(sh, ndx)
{
  type=2;
  wid=sizeof(double);
  initbuffer();
  mybuffer=(double *)buffer;
}

// ---------------------------------------------------------------------
void ColFloat::step(int row)
{
  int pos=row-offset;
  if (pos==buflen) {
    pushbuffer();
    mybuffer=(double *)buffer;
    pos=row-offset;
  }
  if (SQLITE_NULL==sqlite3_column_type(sh,ndx))
    mybuffer[pos]=NullFloat;
  else
    mybuffer[pos]=sqlite3_column_double(sh,ndx);
}
