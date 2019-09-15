#!/bin/bash

# Author:       Anton Krug
# Date:         2019/09/15
# Depending on: http://kmkeen.com/jshon/ for JSON parsing

DEBUG=0  # Set DEBUG=1 to see verbose/debug messages

DESCRIPTIONFILE=_imgurDescriptions.txt

if [ $# -eq 0 ]; then
  echo "No arguments supplied. Usage:"
  echo "imgurDownloader.sh [targetDirectory] URLtoDownload"
  exit 1
fi

DIR=./
URL=$1

if [[ $# -eq 2 ]]; then
  DIR=$1
  URL=$2
fi

if [[ ! $URL =~ ^http[s*]://imgur.com  ]]; then
  echo "No imgur URL detected in '$URL' url!"
  exit 1
fi

hashURL=`echo $URL | cut -d "/" -f 5`
URL="http://imgur.com/ajaxalbums/getimages/$hashURL/hit.json?all=true"
if [ "$DEBUG" -eq "1" ]; then
  echo $URL
fi

gallery=`wget --no-check-certificate -q "$URL" -O -`
if [ "$DEBUG" -eq "1" ]; then
  echo $gallery | xxd
  echo $gallery 
fi

images=`echo $gallery | jshon -e data -e images`
if [ "$DEBUG" -eq "1" ]; then
  echo $gallery | jshon -e album_images -e images
fi

size=`echo $images | jshon -l`
echo "Found $size images, downloading to directory $DIR"

for i in $(seq 0 $((size-1))); do
  image=`echo $images | jshon -e $i`

  title=`echo $image | jshon -e title -u`
  hash=`echo $image | jshon -e hash -u`
  ext=`echo $image | jshon -e ext -u | cut -d '.' -f 2`
  description=`echo $image | jshon -e description`
  if [[ -z $ext ]]; then
    ext = ".jpg"
  fi

  # Escape special characters so we will have valid file name even 
  # for strange titles
  if [ ! -z "$title" ]; then
    title=$(printf '%q' "$title")          # Escape characters
    title=`echo $title | sed 's/\\\ / /g'` # Except spaces (do not escape spaces)
    title=`echo $title | sed 's/\//-/g'`   # Replace all / with -
  fi

  # File naming schema
  FILE=$title-$hash.$ext
  
  if [ -f "$FILE" ]; then
    # It already exists, do not download again
    echo "Skipping '$FILE'..."
  else
    echo -n "Downloading image $i "
    echo "to a file '$FILE'"
    wget --no-check-certificate -q https://i.imgur.com/$hash.$ext -O "$DIR/$FILE"
    if [[ ! -z $description ]]; then
      echo -e "------------------------\n$FILE:\n$description\n\n" >> $DIR/$DESCRIPTIONFILE
    fi
  fi

done
