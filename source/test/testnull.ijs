NB. test nulls

load 'data/sqlite/sqlitez'
db=: dbcreate '~temp/test.db'
dbcmd 'create table tab (a int,b float,c text,d blob)'

dat=. NullInt_psqlite_;NullFloat_psqlite_;NullText_psqlite_;NullText_psqlite_
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
NullInt_psqlite_=: 22
NullFloat_psqlite_=: 33.3
NullText_psqlite_=: 'Nullah'
dbclose''
dbopen '~temp/test.db'
dbreads 'tab'
dat=. NullInt_psqlite_;NullFloat_psqlite_;NullText_psqlite_;NullText_psqlite_
dbinsert 'tab';(;/'abcd');<dat
dbreads 'tab'

dbclose''
load 'data/sqlite/sqlitez'
dbopen '~temp/test.db'
dbreads 'tab'
