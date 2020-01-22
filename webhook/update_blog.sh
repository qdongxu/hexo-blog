#!/bin/bash -xv

if [ -n $HEXOBLOG_HOME ]; then
    HEXOBLOG_HOME=/root/blog
fi

git pull 

cd  $HEXOBLOG_HOME

hexo generate
