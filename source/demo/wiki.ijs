NB. wiki examples

load 'data/sqlite/sqlitez'

db=: sqlopen_psqlite_ '~addons/data/sqlite/db/sandp.db'
sqlhead__db 'sp where qty=400'

load '~addons/data/sqlite/sandp.ijs'
db=: buildsandp '~temp/t1.db'
sqlhead__db 'sp left join s on sp.sid=s.sid where qty=400'

dbopen '~addons/data/sqlite/db/chinook.db'
dbtables''
(;dbsize) every dbtables''
dbhead 'trackid,name,composer from tracks where name like "%snow%"'
6 dbhead 'artists left join albums where artists.artistid=albums.artistid'
dbhead 'customers'
F=: '~temp/t2.db'
db=: sqlcreate_psqlite_ F
dir F
sqlcmd__db 'create table tab (name text, price int)'
sqltables__db''
sqlinsert__db 'tab';('name';'price');<('anne';'bob');10 20
sqlhead__db 'tab'