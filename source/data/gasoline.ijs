NB. gasoline dataset

NB. .mode csv
NB. create table gasoline(rec int,country text,year int,lgaspcar real,lincomep real, lrpmg real,lcarpcap real);
NB. .import ../csv/gasoline.csv gasoline  (not trailing ;)

load 'data/sqlite/sqlitez plot'

dbopen_psqlite_ '~.Sqlite/db/mass.db'

NB. =========================================================
Note''
dbhead 'gasoline'
)
