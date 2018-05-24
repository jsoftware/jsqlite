NB. test nulls

load 'data/sqlite/sqlitez'
db=: dbcreate '~temp/test.db'
dbcmd 'create table tab (a int,b float,c text,d blob)'

dat=. SQLITE_NULL_INTEGER_psqlite_;SQLITE_NULL_FLOAT_psqlite_;SQLITE_NULL_TEXT_psqlite_;SQLITE_NULL_TEXT_psqlite_
dbinsert 'tab';(;/'abcd');<dat
dbreads 'tab'
dbmeta 'tab'

t=. 'one';'two'
s=. t;<t rplc each <'o',{.a.
dbinsert 'tab';(;:'a b c d');<1 2;3.1 5.4;s
dbreads 'tab'

dbcmd 'update tab set a=NULL,b=NULL,c=NULL,d=NULL where rowid=2'
dbreads 'tab'

NB. set nulls:
SQLITE_NULL_INTEGER_psqlite_=: 22
SQLITE_NULL_FLOAT_psqlite_=: 33.3
SQLITE_NULL_TEXT_psqlite_=: 'Nullah'
dbclose''
dbopen '~temp/test.db'
dbreads 'tab'
dat=. SQLITE_NULL_INTEGER_psqlite_;SQLITE_NULL_FLOAT_psqlite_;SQLITE_NULL_TEXT_psqlite_;SQLITE_NULL_TEXT_psqlite_
dbinsert 'tab';(;/'abcd');<dat

ai=. SQLITE_NULL_INTEGER_psqlite_+1
af=. {. _2 (3!:5) a.{~ 239 (6) } 8#255
at=. SQLITE_NULL_TEXT_psqlite_,'z'
dat=. ai;af;at;at
dbinsert 'tab';(;/'abcd');<dat
dbreads 'tab'

dbclose''
load 'data/sqlite/sqlitez'
dbopen '~temp/test.db'
dbreads 'tab'
af -: {:dbexec 'b from tab'
