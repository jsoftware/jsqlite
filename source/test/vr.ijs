NB. vr - Jd lab vehicle registration database

NB. =========================================================
NB. define Jd vr
load 'jd'
load '~addons/data/jd/tutorial/vr_tut.ijs'

NB. =========================================================
NB. define sqlite vr
load 'data/sqlite/sqlitez'
s3Cols=: commasep deb each cutopen VCols rplc 'byte';'text';' 10';''

NB. =========================================================
s3VData=: 3 : 0
dat=. VData y
ndx=. 1 2 5 6 7
(<@dtb"1 each ndx{dat) ndx}dat
)

NB. =========================================================
buildvr=: 3 : 0
len=. y
db=. '~temp/vr.db'
dbcreate db
dbcmd 'create table vr (',s3Cols,')'
dbcmd 'create index idx_make on vr (make)'
blk=. 100000
licx=: 1e9
cls=. ' 'taketo each ',' cutopen s3Cols
while. len > 0 do.
  dbinsert 'vr';cls;<s3VData len <. blk
  len=. len - blk
end.
EMPTY
)

NB. =========================================================
buildboth=: 3 : 0
9!:1[123
build y
9!:1[123
buildvr y
)


NB. =========================================================
NB. sizing:
buildboth 1e3

Note''
buildboth 5e4
buildboth 1e5
buildboth 1e6
)

NB. testing:
jd 'info summary'
dbsize 'vr'

NB. =========================================================
Note''
jd 'reads from vr where make="Ford" and lic<1000000100'
dbreads 'vr where make="Ford" and lic<1000000100'
# each jd 'reads from vr where make="Ford" and lic<1000000100'
# each dbreads 'vr where make="Ford" and lic<1000000100'
)

timex 'jd ''reads from vr where make="Ford" and lic<1000000100'''
timex 'dbreads ''vr where make="Ford" and lic<1000000100'''
