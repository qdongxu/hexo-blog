#!/bin/bash -xv

if [ -n $HEXOBLOG_HOME ]; then
    HEXOBLOG_HOME=/root/hexoblog
fi

git pull --force origin master:master

#cd  $HEXOBLOG_HOME/themes/3-hexo
#git pull --force xdy master:xdy_master

cd $HEXOBLOG_HOME

hexo generate
rm -rf /data/wwwroot/www.kake.one/*
cp -rup /root/hexoblog/public/*  /data/wwwroot/www.kake.one/
cp -rup /root/hexoblog/source/_posts/img  /data/wwwroot/www.kake.one/
