NB. testparm

load 'data/sqlite/sqlitez'
load '~Sqlite/test/gen.ijs'

gen 5
dbhead 'test'

sel=. 'update test set bfloat=? where aint=?'
typ=. SQLITE_FLOAT_psqlite_,SQLITE_INTEGER_psqlite_
dat=. 123.45;75
sqlparm__locDB sel;typ;<dat
dbhead 'test'

sel=. 'update test set aint=?, bfloat=?, ctext=? where dblob=?'
typ=. SQLITE_INTEGER,SQLITE_FLOAT,SQLITE_TEXT,SQLITE_BLOB
dat=. 235;314.159;'williams';'bl',({.a.),'ke'
sqlparm__locDB sel;typ;<dat
dbhead 'test'
