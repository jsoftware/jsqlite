NB. testblob

require 'debug data/sqlite/sqlitez'
dbcreate '~temp/t1.db'
empty dbcmd 'create table tab (d blob)'

bloblen=: 100000

D=: 5$<''
D=: (bloblen#each 'abc') 0 2 4} D
empty dbinsert 'tab';(<'d');<D

D=: (<bloblen#{.a.) 2} D
empty dbcmd 'update tab set d=zeroblob(',(":bloblen),') where rowid=3'

smoutput D=dbexec 'tab'