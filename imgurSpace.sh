#!/bin/bash

#download everything to some predefined directory
DIR=~/Dropbox/docs/_pics/spaceNasa

#author:        Anton Krug
#date:          2015/10/05 
#depending on:  http://kmkeen.com/jshon/ for JSON parsing

if [ $# -eq 0 ]
then
    echo "No arguments supplied. Usage:"
    echo "imgurSpace.sh URLtoDownload"
    exit 1
fi

imgurDownloader.sh $DIR $1
