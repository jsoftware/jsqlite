
#include "jsqlite.h"
#include "parm.h"

extern "C" {
  int sqlite3_write_values(sqlite3_stmt*, int, int, int*, int*, char*);
}

static Parm *get_parm_class(sqlite3_stmt*, int, int, int, char*);

// ---------------------------------------------------------------------
int sqlite3_write_values(sqlite3_stmt* sh, int rws, int cls, int *typ, int* len, char* dat)
{
  int i, j, step;
  int pos=0;

  Parm **parms=(Parm **)malloc(cls * sizeof(char *));
  for (i=0; i<cls; i++) {
    parms[i]=get_parm_class(sh,typ[i],i+1,rws,dat+pos);
    pos+=len[i];
  }

  for (i=0; i<rws; i++) {
    for (j=0; j<cls; j++)
      parms[j]->bind(i);
    step=sqlite3_step(sh);
    if (SQLITE_DONE != step) return step;
    sqlite3_clear_bindings(sh);
    sqlite3_reset(sh);
  }

  for (i=0; i<cls; i++)
    delete parms[i];

  return 0;
}

// ---------------------------------------------------------------------
Parm *get_parm_class(sqlite3_stmt *sh, int type, int ndx, int rws, char* dat)
{
  if (type==1)
    return (Parm *) new ParmInt(sh, ndx, rws, dat);
  if (type==2)
    return (Parm *) new ParmFloat(sh, ndx, rws, dat);
  if (type==3)
    return (Parm *) new ParmText(sh, ndx, rws, dat);
  return (Parm *) new ParmBlob(sh, ndx, rws, dat);
}
