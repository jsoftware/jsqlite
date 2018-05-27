NB. generate test table

load 'data/sqlite/sqlitez'

NB. =========================================================
NB. argument is record count [;file name]
gen=: 3 : 0
9!:1[23
'rws file'=. 2 {. boxxopen y
dbcreate file,(0=#file)#'~temp/test.sqlite'
dbcmd 'create table test (x integer primary key, aint int, bfloat float, ctext text, dblob blob)'
cls=. ;: 'aint bfloat ctext dblob'
nms=. ;: 'adams blake clark dexter fisher jones mason owens riley smith taylor'
a=. 10+?rws$90
b=. 0.001 round_psqlite_ 0.1 * o.a
c=. nms {~ ?rws##nms
d=. c rplc each <'a';({.a.);'o';({:a.);'s';'7'
sqlinsert__locDB 'test';cls;<a;b;c;<d
NB. dbhead 'test'
)

NB. =========================================================
NB. as gen, except:
NB. every 3rd text and blob are empty
NB. every 4th record has null values
genempty=: 3 : 0
9!:1[23
'rws file'=. 2 {. boxxopen y
dbcreate file,(0=#file)#'~temp/test.sqlite'
dbcmd 'create table test (x integer primary key, aint int, bfloat float, ctext text, dblob blob)'
cls=. ;: 'aint bfloat ctext dblob'
nms=. ;: 'adams blake clark dexter fisher jones mason owens riley smith taylor'
a=. 10+?rws$90
b=. 0.001 round_psqlite_ 0.1 * o.a
c=. nms {~ ?rws##nms
d=. c rplc each <'a';({.a.);'o';({:a.);'s';'7'
nth=. 4 : '<: y * 1 + i. <. x % y'
n=. rws nth 3
c=. (<'') n} c
d=. (<'') n} d
n=. rws nth 4
a=. SQLITE_NULL_INTEGER_psqlite_ n} a
b=. __ n} b
c=. (<SQLITE_NULL_TEXT_psqlite_) n} c
d=. (<SQLITE_NULL_TEXT_psqlite_) n} d
sqlinsert__locDB 'test';cls;<a;b;c;<d
dbhead 'test'
)

NB. =========================================================
genx=: 3 : 0
keys=. ;: 'aint'
cls=: ;: 'aint bfloat ctext dblob'
a=. 75 22 93
b=. 12.345 10.001 34.567
c=. ;:'parker grant holmes'
d=. c rplc each <'a';({.a.);'o';({:a.);'s';'7'
sqlupsert__locDB 'test';keys;cls;<a;b;c;<d
dbhead 'test'
)

NB. =========================================================
Note''
echo gen 5
echo genx ''
)
