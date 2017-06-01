
load 'data/sqlite'

NB. =========================================================
sql3=: 3 : 0
'db cmd'=. y
if. IFWIN do.
  spawn_jtask_ 'sqlite3.exe "',(winpathsep db),'" "',cmd,'"'
else.
  2!:0 '/usr/bin/sqlite3 "',db,'" "',cmd,'"'
end.
)

DB=: jpath '~addons/data/sqlite/db/sandp.db'
sql3 DB;'select * from s where status=10 limit 3'
sql3 DB;'select * from s where status=10 limit 1,3'
