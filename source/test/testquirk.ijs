NB. examples in wiki quirks page

load 'data/sqlite'
db=: sqlcreate_psqlite_ jpath '~temp/test.db'
sqlcmd__db 'create table tab (a int,b float,c text)'
sqlinsert__db 'tab';(;:'a b c');<1 2 3;3.1 5.4 6.9;<'one';'two';'three'
sqlreads__db 'tab'
sqlcmd__db 'update tab set a=NULL,b=NULL,c=NULL where rowid=2'
sqlcmd__db 'update tab set a="alan",b="bill",c=123 where rowid=3'

smoutput sqlreads__db 'tab'
smoutput a.i.3!:1[1{sqlexec__db 'b from tab'
