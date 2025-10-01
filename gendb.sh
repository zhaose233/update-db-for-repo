#!/bin/bash

pacman -S --noconfirm jq

mkdir tmp -p

API_URL="https://api.github.com/repos/$1/releases/tags/x86_64"

urls=$(curl -sL "${API_URL}" | jq -r '.assets[].browser_download_url')

for i in ${urls[*]}; do 
pkg=$(echo $i|awk -F '/' '{print$7}')
echo Downloading $pkg
wget -q https://github.com/$i -P tmp/
repo-add -p ${2}.db.tar.gz ./tmp/*.pkg.tar.zst
done

find .
