#!/bin/sh

# Use environment variable to change the prefix, 
# by default it's going to be stored into the:
# /opt/imgurDownloader 
PREFIX=${PREFIX:-/opt/imgurDownloader}

FILE=imgurDownloader.sh
BATCHFILE=imgurListDownloader.sh
EXAMPLEFILE=imgurSpace.sh
VIEWFILE=imgurView.sh
BUFFERFILE=imgurBufferView.sh

echo
echo --------  Dependencies: compiling and installing jshon -----------
echo

if hash jshon 2>/dev/null; then
  echo "Looks 'jshon' is already present, skipping installation"
else
  echo "Installing build depedencies (Ubuntu/Debian only):"
  sudo apt-get install git libjansson-dev # Getting dependancies of dependancies

  echo
  echo "Fetching the source"
  git clone git@github.com:keenerd/jshon.git # Getting source code

  echo
  echo "Complining the source"
  mkdir jshon > /dev/null 2>&1
  cd jshon
  make

  echo
  echo Jshon compiled, trying to install it:
  sudo make install

  cd ..
  rm -rf jshon/  # Removing the jshon source directory
fi


echo
echo ------------------ installing imgurDownloader -------------------
echo

# Making all executable
chmod a+x $FILE $BATCHFILE $EXAMPLEFILE $VIEWFILE $BUFFERFILE batchExample/_runBatchExample.sh

# Copy the file to the target
sudo -s -- "mkdir -p $PREFIX && cp $FILE $PREFIX/$FILE && cp $BATCHFILE $PREFIX/$BATCHFILE && cp $VIEWFILE $PREFIX/$VIEWFILE && cp $BUFFERFILE $PREFIX/$BUFFERFILE"


echo

echo "Creating symbolic link: ~/bin/$FILE"
mkdir ~/bin 1>/dev/null 2>&1
ln -s $PREFIX/$FILE ~/bin/$FILE 1>/dev/null 2>&1

echo "Creating symbolic link: ~/bin/$BATCHFILE"
ln -s $PREFIX/$BATCHFILE ~/bin/$BATCHFILE 1>/dev/null 2>&1

echo "Creating symbolic link: ~/bin/$VIEWFILE"
ln -s $PREFIX/$VIEWFILE ~/bin/$VIEWFILE 1>/dev/null 2>&1

echo "Creating symbolic link: ~/bin/$BUFFERFILE"
ln -s $PREFIX/$BUFFERFILE ~/bin/$BUFFERFILE 1>/dev/null 2>&1

echo "Copying example: ~/bin/$EXAMPLEFILE"
cp $EXAMPLEFILE ~/bin/$EXAMPLEFILE 1>/dev/null 2>&1

echo
echo "Warning!"
echo "If you have not ~/bin in your path these files will not be found anyway, you need to add ~/bin to your PATH enviroment variable"
echo
