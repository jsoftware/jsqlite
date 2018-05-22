
NB. =========================================================
testall=: 3 : 0
loadd '~Sqlite/test/testread.ijs'
loadd '~Sqlite/test/testbig.ijs'
loadd '~Sqlite/test/testblob.ijs'
loadd '~Sqlite/test/testdelete.ijs'
loadd '~Sqlite/test/testtdata.ijs'
loadd '~Sqlite/test/testnull.ijs'
loadd '~Sqlite/test/testupdate.ijs'
loadd '~Sqlite/test/testupsert.ijs'
)

testall''
