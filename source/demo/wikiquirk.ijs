
load 'data/sqlite'

db=: sqlcreate_psqlite_ '~temp/test.db'
sqlcmd__db 'create table tab (a int,b float,c text)'
sqlinsert__db 'tab';(;:'a b c');<1 2;3.1 5.4;<'one';'two'
sqlreads__db 'tab'

sqlcmd__db 'update tab set a="alan",b="bill",c=123 where rowid=2'
sqlreads__db 'tab'