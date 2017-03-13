sql functions:

sqlopen opens a sqlite file, returning locale
dbopen  opens a sqlite file, assigning locale to locDB

The remaining functions can be called in a locale,
otherwise they use the locDB project database locale.
-----------------------------------------------

open file:

loc=: sqlopen filename  NB. called by dbopen

meta:

sqlclose        close file and the locale NB. called by dbclose
sqlcmd          sqlite command exec
sqlcreatedb     create db
sqlinfo         info on connection
sqlinitdb       init database
sqlmeta         meta data for table
sqlreset        reset sql
sqlsize         size of table
sqltables       list of tables
sqlviews        list of views

-----------------------------------------------

table read. All functions call sqlread. The rest are cover functions.

sqlread         read as pair: column_names;list of column_values

formatted reads:
sqlreads        read as table
sqlreadm        read as pair: column_names:matrix of column values
sqlhead         head of table
sqltail         tail of table

other reads:
sqldict         read as dict
sqlexec         read data only
sqlkeysum       read and sum on keys

-----------------------------------------------

table write:
