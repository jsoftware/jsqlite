NB. compare Jd and Sqlite

load 'jd'
load '~addons/data/jd/demo/vr/vr.ijs'
build 1e6

load '~Sqlite/test/vr.ijs'
buildvr '~temp/vr.db';1e6

jd 'reads count lic, fines:sum fine, maxfine:max fine by make from vr'
dbreads 'make, count(lic) as lics, sum(fine) as fines, max(fine) as maxfine from vr group by make'

timex 'jd ''reads count lic, fines:sum fine, maxfine:max fine by make from vr'''
timex 'dbreads ''make, count(lic) as lics, sum(fine) as fines, max(fine) as maxfine from vr group by make'''

$ each jd 'reads * from vr where comment<>""'
$ each dbreads 'vr where comment<>""'

timex 'jd ''reads * from vr where comment<>""'''
timex 'dbreads ''vr where comment<>""'''
