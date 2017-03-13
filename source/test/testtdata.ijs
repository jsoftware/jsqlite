NB. test tdata table

TestDB=: jpath '~temp/test.db'

NB. =========================================================
tdata_defs=: 0 : 0
create table tdata (
NAME varchar(15) collate rtrim,
SEX varchar(1) collate rtrim,
DEPT varchar(4) collate rtrim,
DOB date,
DOH date,
SALARY NUMERIC );
)

NB. =========================================================
tdata_data=: 0 : 0
begin transaction;
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Macdonald B', 'F', 'D101', '1959-06-01', '1978-05-01', 32591);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Genereaux S', 'F', 'D103', '1945-03-01', '1966-02-01', 95415);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Koebel R', 'M', 'D101', '1937-11-01', '1980-09-01', 63374);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Keller J', 'F', 'D101', '1951-05-01', '1974-04-01', 48898);
commit;
)

NB. =========================================================
runtest=: 3 : 0
sqlreset_psqlite_''
db=: sqlcreate_psqlite_ TestDB
r=. sqlcmd__db tdata_defs
if. r do. smoutput 'sqlcmd tdata_defs rc=',":r return. end.
r=. sqlcmd__db tdata_data
if. r do. smoutput 'sqlcmd tdata_data rc=',":r return. end.
smoutput sqlite_info_psqlite_''
smoutput dir TestDB
smoutput sqltables__db''
smoutput sqlmeta__db 'tdata'
smoutput sqlhead__db 'tdata'
)

runtest''