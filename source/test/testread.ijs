NB. testread

NB. first build db with testmake
load '~Sqlite/test/testmake.ijs'
doimport 25

load 'data/sqlite'
db=: sqlopen_psqlite_ F

sqlmeta__db 'tab'
sqlsize__db 'tab'

5 sqlhead__db 'tab'
_5 sqlhead__db 'tab'
5 sqltail__db 'tab'
5 sqlhead__db 'tab where ctext="alice"'
5 sqltail__db 'tab where ctext="alice"'

sqlread__db 'tab where ctext="alice" limit 5'
sqldict__db 'tab where ctext="alice" limit 5'
sqlexec__db 'tab where ctext="alice" limit 5'
sqlexec__db 'aint from tab where ctext="alice" limit 5'

cls=. ;: 'aint bfloat ctext dblob'
dat=. (100+i.3);(200+3.14*i.3);(;:'mary norman otto');<'jedna';'dvě';'tři'
sqlinsert__db 'tab';cls;<dat
5 sqltail__db 'tab'
