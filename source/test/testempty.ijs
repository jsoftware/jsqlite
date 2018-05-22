NB. testempty
NB. test empty and null
load 'data/sqlite/sqlitez'
load '~Sqlite/test/gen.ijs'

dbg 1
dbstops'fixwrite'
genempty 10

a=: dbexec'ctext from test'
b=: dbexec'dblob from test'
2 5 8 -: I. a = <''
3 7 -: I. b = <''

Note''
NB. =========================================================
dbcmd 'update test set aint=NULL,bfloat=NULL,ctext=NULL,dblob=NULL where rowid=2'
dbhead 'test'
a=: dbexec'ctext from test'
b=: dbexec'dblob from test'
1 2 5 8 -: I. a = <''
1 3 7 -: I. b = <''
)
