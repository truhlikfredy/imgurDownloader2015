#!/bin/bash

# Author:       Anton Krug
# Date:         2019/09/15
# Depending on: http://kmkeen.com/jshon/ for JSON parsing

# Will take URLs from Xbuffer
URLA=`xsel -o`

# Will take URLs from clipboard
URLB=`xsel --clipboard -o`

# Detect the absolute location of this script
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Detect if imgur links are present
for URL in `echo $URLA $URLB | xargs`
do
  if [[ $URL =~ ^http[s*]://imgur.com ]];
  then
    DOWNLOAD=`echo $DOWNLOAD $URL`
  fi
done


# Will download all galleries and display them in your favorite image viewer
if [ ! -z DOWNLOAD ]; 
then
  # No duplicates
  DOWNLOAD=`echo $DOWNLOAD | xargs -n1 | sort -u | xargs`
  # Download and display them
  $CURRENT_DIR/imgurView.sh $DOWNLOAD
else
  echo "Nothing downloaded, no imgur links found in clipboard or Xbuffer"
fi
