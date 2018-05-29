
#include "jsqlite.h"
#include "parm.h"

extern "C" {
}

static int exec(void **);
static int rollback(void **);
static Parm *get_parm_class(sqlite3_stmt*, int, int, int, char*);

// ---------------------------------------------------------------------
int exec(void **ch, const char* cmd)
{
  return sqlite3_exec((sqlite3 *)ch,cmd,0,0,0);
}

// ---------------------------------------------------------------------
int rollback(void **ch, int rc)
{
  exec(ch,"rollback");
  return rc;
}

// ---------------------------------------------------------------------
int sqlite3_exec_values(void **ch, const char* sel, int rws, int cls, int *typ, int* len, char* dat)
{
  int i, j, step;
  int pos=0;

  exec(ch,"begin");

  sqlite3_stmt *sh;
  int rc = prepare(ch,sel,&sh);
  if (rc) return rollback(ch,rc);

  Parm **parms=(Parm **)malloc(cls * sizeof(char *));
  for (i=0; i<cls; i++) {
    parms[i]=get_parm_class(sh,typ[i],i+1,rws,dat+pos);
    pos+=len[i];
  }

  for (i=0; i<rws; i++) {
    for (j=0; j<cls; j++)
      parms[j]->bind(i);
    step=sqlite3_step(sh);
    if (SQLITE_DONE != step) return rollback(ch,step);
    sqlite3_clear_bindings(sh);
    sqlite3_reset(sh);
  }

  for (i=0; i<cls; i++)
    delete parms[i];

  sqlite3_finalize(sh);

  exec(ch,"commit");

  return 0;
}

// ---------------------------------------------------------------------
int sqlite3_select_values(void **ch, const char* sel, void **res, int cls, int *typ, int* len, char* dat)
{
  int i;
  int pos=0;

  sqlite3_stmt *sh;
  int rc = prepare(ch,sel,&sh);
  if (rc) return rc;

  Parm **parms=(Parm **)malloc(cls * sizeof(char *));
  for (i=0; i<cls; i++) {
    parms[i]=get_parm_class(sh,typ[i],i+1,1,dat+pos);
    pos+=len[i];
  }

  for (i=0; i<cls; i++)
    parms[i]->bind(0);

  rc = readvalues(sh, res);

  for (i=0; i<cls; i++)
    delete parms[i];

  return rc;
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
