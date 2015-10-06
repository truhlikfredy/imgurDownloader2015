#!/bin/bash

#author:        Anton Krug
#date:          2015/10/05 
#depending on:  http://kmkeen.com/jshon/ for JSON parsing

#will always download to current director
DIR=./

if [ $# -eq 0 ]
then
    echo "No arguments supplied. Usage:"
    echo "imgurBatchDownloader.sh fileWithURLsToDownload"
    exit 1
fi


URLS=$1

#get list, filter imgur links, filter comments, filter garbage, ignore duplicates
LIST=`cat $URLS | grep -v "^#" | grep imgur\.com | sed 's/^.*http:\/\/imgur.com/http:\/\/imgur.com/' | sed 's/\ .*//' | xargs -n1 | sort -u | xargs`

for i in $LIST; do
  if [ ! -z $i ]; then
    echo 
    echo "--- Downloading a gallery $i ---"
    imgurDownloader.sh $DIR $i
  fi
done


