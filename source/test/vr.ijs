NB. vr - Jd lab vehicle registration database

require 'data/sqlite/sqlitez'

NB. utilities
toss=: ? @ (# #) { ]              NB. toss x dice with faces y
wordlines=: [: ;: [: ; ,&' ';._2  NB. multiline wf

MAKES=: 10{.each ;:'Ford Dodge Buick Pontiac Hudson Rambler Toyota Honda Accura VW Mercedes'
COLORS=: 10{.each ;:'Red Green Blue Grey Pink Yellow Mauve Maroon'
TDATA=: 10{.each ''; ;:'Due Unpaid Dead'

FIRSTNAME=: 10{.each wordlines 0 : 0
  Alex Amit Anne Boris Boyd Bruce Carlos Clare Dale Darryn Dianne Graham
  Harlan Harry Helen Jason Jody Johnny Julien Klaus Lewis Linda Lynne Marc
  Margot Milane Munroe Noel Owen Pam Rose Ross Shawn Skip Tom Toshio Troy
  Vin Vince
)

LASTNAME=: 10{.each wordlines 0 : 0
  Abbott Adams Algar Anctil Andrews Beale Boudreau Brady Briscoe Budd
  Cahill Davis Dilworth Donohoe Downs Fobear Foster Gerow Glancey Gordon
  Green Hill Johnson Keegan Keller Kelly Kerik McBride McKee Miller Mills
  Newton Patrick Patten Power Rogerson Stearn Sullivan Tang Taylor
  Thompson
)

VCols=: 'lic int,make text,color text,year int,fine float,firstname text,lastname text,comment text'

NB. =========================================================
NB. generate y random vr records
VData=: 3 : 0
lic=. licx+i.y NB. 1e6+?~y
licx=: licx+y
make=. >y toss MAKES
color=. >y toss COLORS
year=. 1900 + ?y$99
fine=. (+ 10*0<]) 0.01 * (?y$5000) * (?100)=100|i.y
firstname=. >y toss FIRSTNAME
lastname=. >y toss LASTNAME
comment=. >TDATA {~ (0 < fine) * ? y $ #TDATA
lic;make;color;year;fine;firstname;lastname;<comment
)

NB. =========================================================
buildvr=: 3 : 0
'db len'=. y
dbcreate db
dbcmd 'create table vr (',VCols,')'
blk=. 100000
licx=: 1e9
while. len > 0 do.
  dbinsert 'vr';'';<VData len <. blk
  len=. len - blk
end.
EMPTY
)

NB. =========================================================
Note''
buildvr '~temp/vr.db';1e3
dbsize 'vr'
dbhead 'vr'
dbtail 'vr'
dbhead 'count(lic), make from vr group by make'
dbhead 'vr where lic<1000000100 and make="Ford"'
dbhead 'vr where comment<>""'
)
