NB. testbig
NB.
NB. make db of given length and check selected records

load 'data/sqlite/sqlitez'
round=: [ * [: <. 0.5 + %~

dbcreate '~temp/t1.db'
dbcmd 'create table tab (a int,b float,c text,d blob)'

NB. record count
len=: 1e5
bloblen=: 100000

A=: p:i.len
B=: 0.000001 round o.A
C=: ":each B
D=: C ,each 7{a.
D=: (<'') (10*i.<.len%10) }D

cls=: ;/'abcd'

dbinsert 'tab';cls;<A;B;C;<D

dbcmd 'update tab set d=zeroblob(',(":bloblen),') where rowid in (1,2,4,5,8)'
dbcmd 'update tab set d="',(bloblen#'a'),'" where rowid in (3,6,7)'
NB. dbreads 'a,b,c from tab'
NB. check number of items for each column
1 = *./ len = #&> dat1=: >@{: dbread 'tab'
(A;B;<C)-:3{.dat1
NB. test for large bloblen
((<<< 1 2 3 4 5 6 7 8-1){D)-:(<<< 1 2 3 4 5 6 7 8-1){3{::dat1
(5#<bloblen#{.a.)=(1 2 4 5 8-1){3{::dat1
(3#<bloblen#'a')=(3 6 7-1){3{::dat1

NB. read these records
ndx=: (1 2 3 4 5 6 7 8-1) -.~ 6?.len
dat=: dbexec 'tab where rowid in (',')',~}.;(',',":) each ndx+1
dat -: (sort ndx)&{ each A;B;C;<D
