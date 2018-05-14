NB. iris dataset

load 'data/sqlite/sqlitez plot'

dbopen_psqlite_ '~.Sqlite/db/datasets.db'

Note''
dbtables''
dbhead 'iris'
dbdict 'iris'
)

x=. dbexec 'Sepal.Length from iris'
y=. dbexec 'Sepal.Width from iris'

'dot;pensize 4' plot x;y
