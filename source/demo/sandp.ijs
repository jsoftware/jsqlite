NB. wiki sandp examples

load 'data/sqlite/sqlitez data/sqlite/sandp'

fx=: 3 : 0
dat=. ":y
if. 89<{:$dat do.
 (86{."1 dat) ,"1 '..'
end.
)

db=: buildsandp ''
sqltables__db''
sqlmeta__db 's'
fx sqlread__db 'select * from s'
sqlreads__db 'select * from s'
sqlreads__db 's'
sqlreads__db 's where status=30 order by city'
sqlreads__db 'sid,sum(qty),max(qty) from sp group by sid'

sqlread__db 'sid, city from s'
sqlread__db 's'
sqlreads__db each 's';'p';'sp'
sqlhead__db 'sp'
5 sqltail__db 'sp'
sqlreadm__db 's'
sqldict__db 's'
sqlexec__db 'qty from sp'
sqlreads__db 's where status=30 order by city'
sqlreads__db 'sid,sum(qty) from sp group by sid'
sqlkeysum__db 'sp';'sid';'qty'

db=: sqlcopy_psqlite_ '~addons/data/sqlite/db/sandp.db';'~temp/sandp.db'
cls=: ;:'sid name status city'
dat=: ('s6';'s7');('brown';'eaton');40 10;<'rome';'madrid'
sqlinsert__db 's';cls;<dat
5 sqltail__db 's'
sqlreads__db 's'

dat=: ('s5';'s8');('adams';'scott');50 60;<'lisbon';'berlin'
sqlupsert__db 's';'sid';cls;<dat
sqlreads__db 's'
