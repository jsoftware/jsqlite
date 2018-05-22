NB. examples in wiki nulls page

load 'data/sqlite'
db=: sqlcreate_psqlite_ jpath '~temp/test.db'
sqlcmd__db 'create table tab (a int,b float,c text, d blob)'

t=. 'one';'two'
s=. t;<t rplc each <'o',{.a.
sqlinsert__db 'tab';(;:'a b c d');<1 2;3.1 5.4;s
sqlreads__db 'tab'

sqlcmd__db 'update tab set a=NULL,b=NULL,c=NULL,d=NULL where rowid=2'
dat=. NullInt_psqlite_;NullFloat_psqlite_;NullText_psqlite_;NullText_psqlite_
sqlinsert__db 'tab';(;/'abcd');<dat
echo sqlreads__db 'tab'

NB. =========================================================
Note''
smoutput a.i.3!:1[1{sqlexec__db 'b from tab'
)