NB. testblob

load 'data/sqlite/sqlitez'
load '~Sqlite/test/gen.ijs'

gen 5
genx ''

a=: dbexec'ctext from test'
b=: dbexec'dblob from test'
b -: a rplc each <'a';({.a.);'o';({:a.);'s';'7'
