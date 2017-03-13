NB. make sqlite file from command line

F=: jpath '~temp/jext.db'
round=: [ * [: <. 0.5 + %~

NB. =========================================================
sqlite3=: 3 : 0
'db cmd'=. y
if. IFWIN do.
  spawn_jtask_ 'sqlite3.exe "',(winpathsep db),'" "',cmd,'"'
else.
  2!:0 '/usr/bin/sqlite3 "',db,'" "',cmd,'"'
end.
)

NB. =========================================================
NB. create table
Create=: 0 : 0
create table tab(
 aint int,
 bfloat float,
 ctext text,
 dblob blob
);
)

NB. =========================================================
doimport=: 3 : 0
ferase F
sqlite3 F;Create
txt=. ;: 'alice bob charlie dave ethel'
blb=. (;: 'bone btwo bthree bfour') ,each _3<\'沒有沒漢'
cmd=. ''
for_i. i.y do.
 a=. p:i
 b=. 0.001 round o.1+i
 c=. (5|i) pick txt
 d=. (4|i) pick blb
 cmd=. cmd,'insert into tab values (',(":a),',',(":b),',''',c,''',''',d,''');'
end.
cmd=. 'begin;',cmd,';commit;'
sqlite3 F;cmd
smoutput 'imported ',(":y),' records'
)
