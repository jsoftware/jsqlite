NB. make smaller chinook database for addon

NB. =========================================================
NB. copy table between dbs
foo=: 3 : 0
dbcmd sqlschema__db y
dbinsert y;sqlread__db y
)

NB. =========================================================
Note''
load 'data/sqlite/sqlitez'
db=: sqlopen_psqlite_ '~.Sqlite/db/chinook.db'
dbcreate '~Public/data/sqlite/db/chinook.db'
foo 'albums'
foo 'artists'
foo 'customers'
foo 'genres'
foo 'media_types'
foo 'tracks'
dir '~addons/data/sqlite/db'
(;dbsize) &> dbtables''
)