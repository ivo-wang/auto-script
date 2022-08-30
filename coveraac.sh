#!/bin/bash
read_dir(){
cd $1
mkdir aac
find ./ -regex '.*\.avi\|.*\.flv\|.*\.mp4'  -exec sh -c 'ffmpeg -i "$0" -vn -c:a copy "./aac/${0%%.mp4}.aac"' {} \;
}
read_dir $1
