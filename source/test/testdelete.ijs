NB. test delete

load 'data/sqlite/sqlitez'

locDB_z_=: sqlcopy_psqlite_ '~addons/data/sqlite/db/sandp.db';'~temp/sandp.db'

dbreads 's'
dbreads 'from s'
dbcmd 'delete from s where rowid in (2,5)'
dbreads 'rowid,* from s'
cls=: ;:'sid name status city'
dat=: ('s6';'s7');('brown';'eaton');40 10;<'rome';'madrid'
dbinsert 's';cls;<dat
dbreads 'rowid,* from s'

3 dbtail 's'
3 dbtail 'name from s'
