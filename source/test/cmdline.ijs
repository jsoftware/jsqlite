
load 'data/sqlite'

DB=: jpath '~addons/data/sqlite/db/sandp.db'
sql3=: sqlite3do_psqlite_ @ (DB&;)

txt=: 0 : 0
.header on
.mode column
.nullvalue null
select * from s;
)

sqlite3do_psqlite_ DB;txt

sql3 'select * from s where status=10 limit 3;'
sql3 'select * from sp'
