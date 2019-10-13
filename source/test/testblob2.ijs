NB. test two blobs

load 'data/sqlite/sqlitez'

P=: jpath '~temp/test.db'

db=: dbcreate P
dbcmd 'create table tab (a int,b blob,c blob)'
cls=: ;:'a b c'
dat=: 1 2;('one';'two');<'alpha';'beta'

dbinsert 'tab';cls;<dat
echo dbreads 'tab'
(cls,:col dat) -: dbreads'tab'