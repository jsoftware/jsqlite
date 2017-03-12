
#include "column.h"
#include "jsqlite.h"

static int namelen;

// ---------------------------------------------------------------------
Column::Column(sqlite3_stmt *sh, int ndx)
{
  this->sh=sh;
  this->ndx=ndx;
  name=sqlite3_column_name(sh,ndx);
  namelen+=1+strlen(name);
  offset=0;
  len=1020;
  buflen=len;
}

// ---------------------------------------------------------------------
char *Column::getbuffer()
{
  if (buflen==len)
    return buffer;
  buffers.push_back(buffer);
  int bufsize=(int)buffers.size();
  int totlen=len*(4*bufsize-3);
  buffer=(char *)malloc(totlen*wid);
  memcpy(buffer,buffers[0],len*wid);
  int pos=len;
  for (int i=1; i<bufsize; i++) {
    memcpy(buffer+pos*wid,buffers[i],len*4*wid);
    pos+=len*4;
  }
  for (int i=0; i<bufsize; i++)
    free(buffers[i]);
  return buffer;
}

// ---------------------------------------------------------------------
int Column::getnamelen()
{
  return namelen;
}

// ---------------------------------------------------------------------
void Column::initbuffer()
{
  buffer=(char *) malloc(buflen*wid);
}

// ---------------------------------------------------------------------
void Column::pushbuffer()
{
  buffers.push_back(buffer);
  offset=offset+buflen;
  buflen=len*4;
  buffer=(char *) malloc(buflen*wid);
}
