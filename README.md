#imgurDownloader2015
This is set of bash scripts which automated downloading images from imgur.

![solved maze]
(https://raw.githubusercontent.com/truhlikfredy/imgurDownloader2015/master/screenShotsM/00.png)

##Heartbeat
Because I hate downloading some tools to find they are not compatible anymore with given service I will post here from time to time that this tool still works.
####2015/10/06 - tested and working

##Features
- Will download all images from single gallery **imgurDownloader.sh**
- Bulk downloader which download multiple galleries form a list (given in a filename). **imgurListDownloader.sh** 
- Will download given URL into temp folder and display it in specified viewer **imgurView.sh**
- Automatic downloader from clipboard and Xbuffer. **imgurBufferView.sh**
- Will ignore duplicate galleries and duplicate files.
- Escapes strange characters in titles.
- Stores descriptions to images to separate text file.

##Dependencies
- jshon (http://kmkeen.com/jshon/)
- xsel (only if you inted use **imgurBufferView.sh**)
- bash (it's bash scripts)

##License
GPL (https://www.gnu.org/licenses/gpl.txt)

##imgurDownloader.sh
Basic script which will download all images on given URL to given directory. (will skip duplicates).

##imgurListDownloader.sh
Will download bull number of galeries from supplied text file (the file can be messy and it will still detect the imgur URLs).

##imgurBufferView.sh
Will take any content from clipboard and even Xbuffer and will search for any imgur URLs to download. (will ignore duplicates). The Xbuffer is anything that you select in X11 enviroment. This means that when you going to copy something into clipboard you are selecting it first. The moment it's selected it's stored in the Xbuffer. This way you save lot of time. Just clicking on URL bar will often select the whole URL. 

Now just open console or make desktop shortcut for this command and it will download all images into temporary directory and display them using **comix** image viewers (the viewer can be changed).

Similar as **imgurView.sh** but it's automatic and you don't have to type the URLs.

Note: Selections or clipboard (or both) can contain multiple URLs. 

##imgurView.sh
Will download give gallery into temporary folder and display it using **comix**. This is good when somebody wants to just watch the images outside web-browser. 

It's benificial for:
- Low resources computers and galleries witch very large images (build in image viewers are more efficient to view images than web browsers).
- Somebody with limited or problematic internet access (preloads whole content).
- Somebody who hates imgur UI and wants to view images outside their website.


##Install.sh
Not really needed, it will just:
- Download **jshon** and will try to build it (Debian centrict, using **apt-get**).
- Will copy scripts into **/opt/imgurDownloader** and place symbolic links to your home **/bin** directory. If you will have not the **~/bin** in your **PATH** enviroment variables it will not work anyway.

This can be done by hand, just copy the **\*.sh** files somewhere where they will be in the **PATH** enviroment variable. And make sure the jshon (needed for all scripts) and xsel (needed just for 1 script) are installed.

##batchExample
This folder contains example list and example syntex how to download multiple galeries in one go.
