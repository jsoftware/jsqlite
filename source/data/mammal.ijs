NB. mammal dataset

NB. .mode csv
NB. create table mammals("name" TEXT,"body" REAL,"brain" REAL);
NB. .import ../csv/mammals.csv mammals  (not trailing ;)

load 'data/sqlite/sqlitez plot'

dbopen '~.Sqlite/db/mass.db'

NB. =========================================================
Note''
dbhead 'mammals'

x=. dbexec 'Body from mammals'
y=. dbexec 'Brain from mammals'

'dot;pensize 4' plot x;y
)
