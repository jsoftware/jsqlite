
#include "column.h"

static vector<I> blobsizes;

// ---------------------------------------------------------------------
ColBlob::ColBlob(sqlite3_stmt *sh,int ndx) : Column(sh, ndx)
{
  pos=SZI;
  type=4;
  wid=30;
  blobsizes.clear();
  initbuffer();
}

// ---------------------------------------------------------------------
char *ColBlob::getbuffer()
{
  int rws=(int)blobsizes.size();
  I end=(I) pos;

  int bufsize=(int)buffers.size();
  if (bufsize>0)
    end+=len*wid*(4*bufsize-3);   // 4-1=3
  end+=rws*SZI;
  char *res=(char *)malloc(end);
  ((I*)res)[0]=end;
  memcpy(res+SZI, &blobsizes[0], rws*SZI);
  int hdr=SZI*(rws+1);
  char *buf=Column::getbuffer();
  memcpy(res+hdr, buf+SZI, end-hdr);
  free(buf);
  return res;
}

// ---------------------------------------------------------------------
void ColBlob::step(int row)
{
  char *s;
  int bytes;
  int bufwid=buflen*wid;

  if (SQLITE_NULL==sqlite3_column_type(sh,ndx)) {
    s=NullText;
    bytes=strlen(s);
  } else {
    s=(char *)sqlite3_column_blob(sh,ndx);
    bytes=sqlite3_column_bytes(sh,ndx);
  }

  blobsizes.push_back(bytes);

  while (1) {
    if (bufwid >= pos+bytes)
      break;
    memcpy(buffer+pos,s,bufwid-pos);
    pushbuffer();
    s+=bufwid-pos;
    bytes-=bufwid-pos;
    bufwid=buflen*wid;
    pos=0;
  }

  memcpy(buffer+pos,s,bytes);
  pos+=bytes;
}

