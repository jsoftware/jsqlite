
load 'data/sqlite/sqlitez data/sqlite/sandp'
db=: buildsandp '~temp/t1.db'
sqlreads__db 'p'
sqlupdate__db 'p';'weight=12';('name';'city');<'hammer';'vienna'
sqlreads__db 'p'
