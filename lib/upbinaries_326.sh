#!/bin/bash

R=326
C=/home/chris/dev/apps/sqlite/lib/web326

SVR=root@anna
T=/var/www/html/download/sqlitebin/$R

shopt -s dotglob
rsync -aL $C/* $SVR:/$T
ssh $SVR chown -R web:web $T
ssh $SVR chmod 644 $T/libjsqlite3*

echo "done. press enter to exit"
read wait
