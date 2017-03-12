
#include "column.h"

static vector<long long> blobsizes;

// ---------------------------------------------------------------------
ColBlob::ColBlob(sqlite3_stmt *sh,int ndx) : Column(sh, ndx)
{
  pos=8;
  type=4;
  wid=30;
  blobsizes.clear();
  initbuffer();
}

// ---------------------------------------------------------------------
char *ColBlob::getbuffer()
{
  int rws=blobsizes.size();
  long long end=(long long) pos;

  int bufsize=(int)buffers.size();
  if (bufsize>0)
    end+=len*wid*(4*bufsize-3);
  end+=rws*8;
  char *res=(char *)malloc(end);
  ((long long*)res)[0]=end;
  memcpy(res+8, &blobsizes[0], rws*8);
  int hdr=8*(rws+1);
  char *buf=Column::getbuffer();
  memcpy(res+hdr, buf+8, end-hdr);
  free(buf);
  return res;
}

// ---------------------------------------------------------------------
void ColBlob::step(int row)
{
  if (SQLITE_NULL==sqlite3_column_type(sh,ndx)) {
    blobsizes.push_back(0);
    return;
  }

  int bufwid=buflen*wid;
  char *s=(char *)sqlite3_column_blob(sh,ndx);
  int bytes=sqlite3_column_bytes(sh,ndx);
  blobsizes.push_back(bytes);

  while (1) {
    if (bufwid >= pos+bytes)
      break;
    memcpy(buffer+pos,s,bufwid-pos);
    pushbuffer();
    s+=bufwid-pos;
    bytes-=bufwid-pos;
    pos=0;
  }

  memcpy(buffer+pos,s,bytes);
  pos+=bytes;
}

