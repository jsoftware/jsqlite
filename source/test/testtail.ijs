NB. test tail

load 'data/sqlite/sqlitez'

dbopen '~addons/data/sqlite/db/chinook.db'

dbtail 'tracks'
5 dbtail 'tracks'
5 dbtail 'TrackId, AlbumId,GenreId,Composer from tracks'
5 dbtail 'TrackId, AlbumId,GenreId,Composer from tracks where GenreId=24'
5 dbtail 'TrackId, AlbumId,GenreId,Composer from tracks where GenreId<>24'
dbtail 'TrackId, AlbumId,GenreId,MediaTypeId,Composer from tracks where MediaTypeId in (3,4)'

dbopen '~addons/data/sqlite/db/sandp.db'
f=. 4 : 'astable_psqlite_ x sqltailx__locDB y'
5 f 'sp'
5 f 'qty,pid from sp'
5 f 'qty,pid from sp where pid="p2"'
5 f 'qty,pid from sp where pid<>"p2"'
10 f 'sp where qty in (100,400)'
