NB. test with utf8 text

load 'data/sqlite/sqlitez'

NB. =========================================================
NB. argument is record count [;file name]
testuni=: 3 : 0
dbcreate '~temp/test.sqlite'
dbcmd 'create table test (x integer primary key, aint int, bfloat float, ctext text, dblob blob)'
cls=. ;: 'aint bfloat ctext dblob'
a=. 10+?5$90
b=. 0.001 round_psqlite_ 0.1 * o.a
c=. <;._1 ' adams 沒有沒漢 αβγδε ∀∃∅△∮ ', 8&u: 10&u: 16b1f600+i.8
d=. c rplc each <'a';({.a.);'s';{:a.
dbinsert 'test';cls;<a;b;c;<d
dbhead 'test'
)

echo testuni''
