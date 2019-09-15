#!/bin/bash

# Author:       Anton Krug
# Date:         2019/09/15
# Depending on: http://kmkeen.com/jshon/ for JSON parsing

# Download everything to some predefined directory, if enviroment variable is
# Not given then download the images to this folder
DIR=${DIR:-~/Dropbox/docs/_pics/spaceNasa}

# Detect the absolute location of this script
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


if [ $# -eq 0 ]
then
    echo "No arguments supplied. Usage:"
    echo "imgurDirectory.sh URLtoDownload"
    echo ""
    echo "Environment variable DIR can be used to store the images,"
    echo "by default this $DIR is used."
    exit 1
fi


$CURRENT_DIR/imgurDownloader.sh $DIR $1
