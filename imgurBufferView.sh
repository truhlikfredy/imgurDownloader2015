#!/bin/bash

#author:        Anton Krug
#date:          2015/10/05
#depending on:  xsel, jshon


#will take URLs from Xbuffer
URLA=`xsel -o`

#will take URLs from clipboard
URLB=`xsel --clipboard -o`


#detect if imgur links are present
for URL in `echo $URLA $URLB | xargs`
do
  if [[ $URL =~ ^http://imgur.com ]];
  then
    DOWNLOAD=`echo $DOWNLOAD $URL`
  fi
done


#will download all galleries and display them in your favorite image viewer
if [ ! -z DOWNLOAD ]; 
then
  #no duplicates
  DOWNLOAD=`echo $DOWNLOAD | xargs -n1 | sort -u | xargs`
  #download and display them
  imgurView.sh $DOWNLOAD
else
  echo "Nothing downloaded, no imgur links found in clipboard or Xbuffer"
fi
