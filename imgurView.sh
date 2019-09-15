#!/bin/bash

# Author:       Anton Krug
# Date:         2019/09/15
# Depending on: http://kmkeen.com/jshon/ for JSON parsing

# Your favorite image viewer, if no env variable given, use this:
imageViewer=${imageViewer:-comix}

# Detect the absolute location of this script
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ $# -eq 0 ]
then
    echo "No arguments supplied. Usage:"
    echo "imgurView. URLtoView [moreURLsToView] [moreURLsToView]"
    echo ""
    echo "Environment variable can change what viewer is used,"
    echo "by default"
    exit 1
fi

# Create the temporary directory
DIR=`mktemp -d`

cd $DIR
for i in $@
do
    echo "Downloading gallery $i"
    $CURRENT_DIR/imgurDownloader.sh $DIR $i
done

# After all galleries are downloaded display them in your favorite image viewer
$imageViewer $DIR

# Remove the temporary directory
rm -rf $DIR/
