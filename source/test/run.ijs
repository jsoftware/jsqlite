
NB. =========================================================
testall=: 3 : 0
loadd '~Sqlite/test/testread.ijs'
loadd '~Sqlite/test/testbig.ijs'
loadd '~Sqlite/test/testtdata.ijs'
loadd '~Sqlite/test/testquirk.ijs'
loadd '~Sqlite/test/testupsert.ijs'
)

testall''
