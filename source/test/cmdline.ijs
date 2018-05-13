
load 'data/sqlite'

DB=: '~addons/data/sqlite/db/sandp.db'
sql3=: sqlite3do_psqlite_ @ (DB&;)

sql3 'select * from s where status=10 limit 3;'
sql3 'select * from sp'
