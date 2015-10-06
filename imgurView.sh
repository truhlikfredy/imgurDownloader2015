#!/bin/bash

#your favorite image viewer
imageViewer=comix

#author:        Anton Krug
#date:          2015/10/05 
#depending on:  http://kmkeen.com/jshon/ for JSON parsing

if [ $# -eq 0 ]
then
    echo "No arguments supplied. Usage:"
    echo "imgurView. URLtoView [moreURLsToView] [moreURLsToView]"
    exit 1
fi

#create the temporary directory
DIR=`mktemp -d`

cd $DIR
for i in $@
do
    echo "Downloading gallery $i"
    imgurDownloader.sh $DIR $i
done

#after all galleries are downloaded display them in your favorite image viewer
$imageViewer $DIR


#remove the temporary directory
rm -rf $DIR/
