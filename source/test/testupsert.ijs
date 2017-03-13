
load '~Sqlite/test/testmake.ijs'
doimport 5

load 'data/sqlite'
db=: sqlopen_psqlite_ F
smoutput sqlexec__db 'rowid,* from tab'
smoutput sqlreads__db 'rowid,* from tab'

cls=. ;:'aint ctext bfloat'
dat=. 2 7 5;(;:'alice dave charlie');0.001 round o. 1 4 3

sqlupsert__db 'tab';cls;cls;<dat
smoutput sqlreads__db 'rowid,* from tab'

dat=. 2 7 5;(;:'alice dave charlie');0.001 round o. 1 4 23
sqlupsert__db 'tab';(;:'aint ctext');cls;<dat
smoutput sqlreads__db 'rowid,* from tab'

dat=. 2 7 5;(;:'alice delia cathy');0.001 round o. 1 4 23
sqlupsert__db 'tab';(;:'aint bfloat');cls;<dat
smoutput sqlreads__db 'rowid,* from tab'
