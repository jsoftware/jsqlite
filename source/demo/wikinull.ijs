NB. examples in wiki nulls page

load 'data/sqlite/sqlitez'
dbcreate jpath '~temp/test.db'
dbcmd 'create table tab (a int,b float,c text, d blob)'

t=. 'one';'two'
s=. t;<t rplc each <'o',{.a.
dbinsert 'tab';(;:'a b c d');<1 2;3.1 5.4;s
dbreads 'tab'

dbcmd 'update tab set a=NULL,b=NULL,c=NULL,d=NULL where rowid=2'
dat=. SQLITE_NULL_INTEGER_psqlite_;SQLITE_NULL_FLOAT_psqlite_;;~SQLITE_NULL_TEXT_psqlite_
dbinsert 'tab';(;/'abcd');<dat
dbreads 'tab'

dbclose''

SQLITE_NULL_INTEGER_psqlite_=: 23
SQLITE_NULL_FLOAT_psqlite_=: 234.56
SQLITE_NULL_TEXT_psqlite_=: 'Nullah'
dbopen jpath '~temp/test.db'
dbreads 'tab'

dbclose ''
load 'data/sqlite/sqlitez'
dbopen jpath '~temp/test.db'
dbreads 'tab'
