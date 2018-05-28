NB. testparm

load 'data/sqlite/sqlitez'
load '~Sqlite/test/gen.ijs'

gen 5

sel=. 'update test set bfloat=? where aint=?'
typ=. SQLITE_FLOAT,SQLITE_INTEGER
dat=. 123.45;75
sqlparm__locDB sel;typ;<dat
dbhead 'test'

sqlcmd__locDB 'begin;'
sel=. 'update test set aint=?, bfloat=?, ctext=? where dblob=?'
typ=. SQLITE_INTEGER,SQLITE_FLOAT,SQLITE_TEXT,SQLITE_BLOB
dat=. 235;314.159;'williams';'bl',({.a.),'ke'
sqlparm__locDB sel;typ;<dat
sqlcmd__locDB 'commit;'
dbhead 'test'

sel=. 'select * from test where aint=?'
dat=. 75
sqlparm__locDB sel;SQLITE_INTEGER;dat
sqlparm__locDB sel;dat

sel=. 'select * from test where aint in (?,?)'
dat=. 75;235
sqlparm__locDB sel;<dat
