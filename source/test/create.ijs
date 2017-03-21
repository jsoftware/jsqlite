NB. create table example

load 'data/sqlite'

F=: '~temp/t1.db'
db=: sqlcreate_psqlite_ F
dir F
sqlcmd__db 'create table tab (name text, price int)'
dir F
sqltables__db''
sqlinsert__db 'tab';('name';'price');<('anne';'bob');10 20
sqlhead__db'tab'
1 sqltail__db 'name from tab'