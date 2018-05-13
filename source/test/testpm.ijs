NB. test pm on sqlite

load '~Sqlite/test/vr.ijs'
load 'jpm'

start_jpm_ ''
buildvr '~temp/vr.db';1e3
showtotal_jpm_''

start_jpm_ 1e8
buildvr '~temp/vr.db';1e4
showtotal_jpm_''

start_jpm_ ''
buildvr '~temp/vr.db';1e4
showtotal_jpm_''
