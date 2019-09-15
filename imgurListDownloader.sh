#!/bin/bash

# Author:       Anton Krug
# Date:         2019/09/15
# Depending on: http://kmkeen.com/jshon/ for JSON parsing

# Will always download to current director
DIR=./

# Detect the absolute location of this script
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ $# -eq 0 ]
then
    echo "No arguments supplied. Usage:"
    echo "imgurBatchDownloader.sh fileWithURLsToDownload"
    exit 1
fi

URLS=$1

# Get list, filter imgur links, filter comments, filter garbage, 
# ignore duplicates
LIST=`cat $URLS | grep -v "^#" | grep imgur\.com | sed 's/^.*http[s*]:\/\/imgur.com/http[s*]:\/\/imgur.com/' | sed 's/\ .*//' | xargs -n1 | sort -u | xargs`

for i in $LIST; do
  if [ ! -z $i ]; then
    echo 
    echo "--- Downloading a gallery $i ---"
    $CURRENT_DIR/imgurDownloader.sh $DIR $i
  fi
done


