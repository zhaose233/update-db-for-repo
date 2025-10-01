#!/bin/bash

mkdir tmp -p

urls=$(curl https://github.com/$1/releases/tag/x86_64 -s|grep "/$1/releases/download/x86_64/"|awk -F '"|"' '{print$2}')

for i in ${urls[*]}; do 
pkg=$(echo $i|awk -F '/' '{print$7}')
echo Downloading $pkg
wget -q https://github.com/$i -P tmp/
repo-add -p ${2}.db.tar.gz ./tmp/*.pkg.tar.zst
done

find .
