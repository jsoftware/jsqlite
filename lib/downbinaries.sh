#!/bin/bash

R=104

SVR=root@anna
T=/var/www/html/download/sqlitebin/$R/*
P=/home/chris/temp/sqlitebin
C=/home/chris/dev/apps/sqlite/lib/web

mkdir -p $P
rm -rf $P/*
rsync -prtLz $SVR:$T $P
meld $P $C

echo "done. press enter to exit"
read wait
