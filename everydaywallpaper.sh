#!/bin/bash
# ps this script will set wallpaper is bing's image everyday
# $bing is needed to form the fully qualified URL for
sleep 200
# the Bing pic of the day
bing="cn.bing.com"

# $xmlURL is needed to get the xml data from which
# the relative URL for the Bing pic of the day is extracted
#
# The mkt parameter determines which Bing market you would like to
# obtain your images from.
# Valid values are: en-US, zh-CN, ja-JP, en-AU, en-UK, de-DE, en-NZ, en-CA.
#
# The idx parameter determines where to start from. 0 is the current day,
# 1 the previous day, etc.
xmlURL="http://cn.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=1&mkt=zh-CN"

# $saveDir is used to set the location where Bing pics of the day
# are stored. $HOME holds the path of the current user's home directory
saveDir=$HOME'/Pictures/BingPics/'

# Create saveDir if it does not already exist
mkdir -p $saveDir

# Set picture options
# Valid options are: none,wallpaper,centered,scaled,stretched,zoom,span ned
picOpts="zoom"

# The desired Bing picture resolution to download
# Valid options: "_1024x768" "_1280x720" "_1366x768" "_1920x1200"
picRes="_1920x1200"

# The file extension for the Bing pic
picExt=".jpg"

# Extract the relative URL of the Bing pic of the day from
# the XML data retrieved from xmlURL, form the fully qualified
# URL for the pic of the day, and store it in $picURL
picURL=$bing$(echo $(curl -s $xmlURL) | grep -oP "<urlBase>(.*)</urlBase>" | cut -d ">" -f 2 | cut -d "<" -f 1)$picRes$picExt

# $picName contains the filename of the Bing pic of the day
picName=${picURL#*2f}

# Download the Bing pic of the day
curl --create-dirs -s -o $saveDir$picName $picURL

# Set the GNOME3 wallpaper
DISPLAY=:0 GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.background picture-uri '"file://'$saveDir$picName'"'

# Set the GNOME 3 wallpaper picture options
DISPLAY=:0 GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.background picture-options $picOpts

# Remove pictures older than 7 days
find $saveDir -atime +7 -delete

# Exit the script
exit
