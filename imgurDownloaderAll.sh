#!/bin/bash

#author:        Anton Krug
#date:          2016/01/24
#depending on:  http://kmkeen.com/jshon/ for JSON parsing

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

if [[ ! $URL =~ ^http://imgur.com ]]; then
  echo "Not imgur detected in '$URL' url!"
  exit 1
fi

hashURL=`echo $URL | cut -d "/" -f 5`
URL="http://imgur.com/ajaxalbums/getimages/$hashURL/hit.json?all=true"
#echo $URL

#gallery=`wget -q "$URL" -O - | grep -e "image.*\: {" | sed -e 's/^\ *image\ *: //' | sed -e 's/,$//'`
gallery=`wget -q "$URL" -O -`
#echo $gallery | xxd
#echo $gallery 

#images=`echo $gallery | jshon -e album_images -e images`
images=`echo $gallery | jshon -e data -e images`
#echo $gallery | jshon -e album_images -e images

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

  #escape special characters so we will have valid file name even for strange titles
  if [ ! -z "$title" ]; then
    title=$(printf '%q' "$title")                   #escape characters
    title=`echo $title | sed 's/\\\ / /g'`          #except spaces, do not escape spaces
    title=`echo $title | sed 's/\//-/g'`            #replace all / with -
  fi

  #file naming schema
  FILE=$title-$hash.$ext
  

  if [ -f "$FILE" ]; then
    #it already exists, do not download again
    echo "Skipping '$FILE'..."
  else
    echo -n "Downloading image $i "
    echo "to a file '$FILE'"
    wget -q http://i.imgur.com/$hash.$ext -O "$DIR/$FILE"
    if [[ ! -z $description ]]; then
      echo -e "------------------------\n$FILE:\n$description\n\n" >> $DIR/$DESCRIPTIONFILE
    fi
  fi

done


