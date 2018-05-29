/* jsqlite.cpp  */

#ifdef ANDROID
extern "C" {
  extern void *__dso_handle __attribute__((__visibility__("hidden")));
  void *__dso_handle;
}
#endif

#include "jsqlite.h"
#include "column.h"

static Column *get_column_class(sqlite3_stmt *, int, int);
static int get_column_types(sqlite3_stmt *, int, vector<int> &);

bool DEBUG=false;
I NullInt;
double NullFloat;
char* NullText=0;

// ---------------------------------------------------------------------
struct Result {
  void *values;         // column values
  void *types;          // column types
  void *names;          // column names
  I nameslen;           // length of column names
  I rows;               // rows in result
  I cols;               // columns in result
};

// ---------------------------------------------------------------------
// cover for open that adds the text/blob null value
int sqlite3_extopen(const char* file, sqlite3** hnd, int flgs,
                    I ni, double nd, const char* nt, const char* vfs)
{
  NullInt=ni;
  NullFloat=nd;
  free(NullText);
  NullText=(char*)malloc(strlen(nt)+1);
  strcpy(NullText,nt);
  return sqlite3_open_v2(file, hnd, flgs, vfs);
}

// ---------------------------------------------------------------------
// return extension version in the form 100 base major,minor, e.g. 101
int sqlite3_extversion()
{
  return 106;
}

// ---------------------------------------------------------------------
int sqlite3_free_values(void **res)
{
  Result *vals=(Result *) *res;
  char **colbuffer=(char **)vals->values;
  for (int i=0; i<vals->cols; i++)
    free(colbuffer[i]);
  free(vals->values);
  free(vals->types);
  free(vals->names);
  free(vals);
  return 0;
}

// ---------------------------------------------------------------------
int sqlite3_read_values(void **hp, const char* sel, void **res)
{
  sqlite3_stmt *sh;
  int rc = prepare((sqlite3 *)hp,sel,&sh);
  if (rc) return rc;
  return readvalues(sh, res);
}

// ---------------------------------------------------------------------
int prepare(sqlite3 *ch, const char *sel, sqlite3_stmt **sh)
{
  return sqlite3_prepare_v2(ch,sel,strlen(sel),sh,0);
}

// ---------------------------------------------------------------------
int readvalues(sqlite3_stmt *sh, void **res)
{
  Result *vals = (Result *)malloc(sizeof(Result));

  int i, pos, step;
  const char *name;

// init columns
  int numcols=sqlite3_column_count(sh);

  vector<int> types(numcols,0);
  step=get_column_types(sh,numcols,types);
  if (step==1) return step;

  Column **columns=(Column **)malloc(numcols * sizeof(char *));
  for (i=0; i<numcols; i++)
    columns[i]=get_column_class(sh,i,types[i]);

// get data
  pos=0;
  while (SQLITE_ROW == (step=sqlite3_step(sh))) {
    for (i=0; i<numcols; i++)
      columns[i]->step(pos);
    pos++;
  }

  char **colbuffer = (char **)malloc(numcols * sizeof(char *));
  I *coltypes = (I *)malloc(numcols * sizeof(I));
  for (i=0; i<numcols; i++) {
    colbuffer[i]=columns[i]->getbuffer();
    coltypes[i]=columns[i]->gettype();
  }

  vals->values=(void *)colbuffer;
  vals->types=(void *)coltypes;
  vals->rows=pos;
  vals->cols=numcols;

// get colnames
  char *colnames = (char *)malloc(columns[0]->getnamelen());
  pos=0;
  for (i=0; i<numcols; i++) {
    name=columns[i]->getname();
    strcpy(colnames+pos,name);
    pos+=1+(int)strlen(name);
  }
  vals->names=(void *)colnames;
  vals->nameslen=pos;
  *res=vals;

  for (i=0; i<numcols; i++)
    delete columns[i];

  sqlite3_finalize(sh);
  return step;
}

// ---------------------------------------------------------------------
Column *get_column_class(sqlite3_stmt *sh, int i, int type)
{
  if (type==1)
    return (Column *) new ColInt(sh, i);
  if (type==2)
    return (Column *) new ColFloat(sh, i);
  if (type==3)
    return (Column *) new ColText(sh, i);
  if (type==4)
    return (Column *) new ColBlob(sh, i);
  return (Column *) new ColInt(sh, i);
}

// ---------------------------------------------------------------------
int get_column_types(sqlite3_stmt *sh, int numcols, vector<int> &types)
{
  int i, step;
  const char *decl;

  for (i=0; i<numcols; i++) {
    decl=sqlite3_column_decltype(sh, i);
    types[i]=decl2type(decl);
  }

  // for now, if any nulls determine type from first row
  // and set any null to text
  if (!has(types,5)) return 0;

  step=sqlite3_step(sh);
  if (SQLITE_ROW != step && SQLITE_DONE != step) return step;
  if (SQLITE_ROW == step) {
    for (i=0; i<numcols; i++)
      if (types[i]==5)
        types[i]=sqlite3_column_type(sh,i);
  }
  sqlite3_reset(sh);
  for (i=0; i<numcols; i++)
    if (types[i]==5)
      types[i]=3;

  return 0;
}

