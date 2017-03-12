
#include "column.h"

static char NullText='\0';

// ---------------------------------------------------------------------
ColText::ColText(sqlite3_stmt *sh,int ndx) : Column(sh, ndx)
{
  pos=SZI;
  type=3;
  wid=30;
  initbuffer();
}

// ---------------------------------------------------------------------
char *ColText::getbuffer()
{
  I end=(I) pos;
  int bufsize=(int)buffers.size();
  if (bufsize>0)
    end+=len*wid*(4*bufsize-3);
  char *buf=Column::getbuffer();
  ((I*)buf)[0]=end;
  return buf;
}

// ---------------------------------------------------------------------
void ColText::step(int row)
{
  int len;
  int bufwid=buflen*wid;

  if (pos==bufwid) {
    pushbuffer();
    bufwid=buflen*wid;
    pos=0;
  }

  if (SQLITE_NULL==sqlite3_column_type(sh,ndx)) {
    buffer[pos++]=NullText;
    return;
  }

  string s((char *)sqlite3_column_text(sh,ndx));

  while (1) {
    len=1+(int)s.size();
    if (bufwid >= pos+len)
      break;
    memcpy(buffer+pos,s.c_str(),bufwid-pos);
    s=s.substr(bufwid-pos);
    pushbuffer();
    pos=0;
  }
  memcpy(buffer+pos,s.c_str(),len);
  pos+=len;
}

