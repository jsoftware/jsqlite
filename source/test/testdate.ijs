NB. generate test date table

load 'data/sqlite/sqlitez'
load 'jd'

NB. =========================================================
NB. argument is record count [;file name]
testdate=: 3 : 0
y=. 5
'rws file'=. 2 {. boxxopen y
dbcreate file,(0=#file)#'~temp/test.sqlite'
dbcmd 'create table test (x integer primary key, adate int, bdatetime int, cdatetimem text)'
cls=. ;: 'adate bdatetime cdatetimem'
off=. 86400 * todayno 2000 1 1
d=. efs_jd_ '2018-08-29T10:11:12.345'
a=. off + 86400 * (<.d % 864e11) + i.rws
b=. off + (<.d % 1e9) + i.rws
c=. '. m' sfe_jd_ d + 1e6*i.rws
dbinsert 'test';cls;<a;b;<<"1 c
dbhead 'test'
)

NB. =========================================================
Note''
echo testdate 5
)

echo testdate 5
