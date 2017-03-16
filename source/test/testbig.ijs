NB. testbig
NB.
NB. make db of given length and check selected records

require 'data/sqlite/sqlitez'
round=: [ * [: <. 0.5 + %~

dbcreate '~temp/t1.db'
dbcmd 'create table tab (a int,b float,c text,d blob)'

NB. record count
len=: 1e5

A=: p:i.len
B=: 0.000001 round o.A
C=: ":each B
D=: C ,each 7{a.
D=: (<'') (10*i.<.len%10) }D
NB. D=: len#<''

cls=: ;/'abcd'
dbinsert 'tab';cls;<A;B;C;<D
dbreads 'tab'
NB. check number of items for each column
echo #&> >@{: dbread 'tab'

NB. read these records
ndx=: 6?.len
dat=: dbexec 'tab where rowid in (',')',~}.;(',',":) each ndx+1
dat -: (sort ndx)&{ each A;B;C;<D
