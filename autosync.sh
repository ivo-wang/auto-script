#!/bin/bash
ssh root@45.62.118.157 -p 29006 > /dev/null 2>&1 << eeooff
tree -if /var/ftp > /var/ftp/1.tt
exit
eeooff
aria2c ftp://45.62.118.157/1.tt

sed 's/\/var\/ftp/ftp:\/\/45.62.118.157/g' 1.tt > 2.tt && sed '/^$/d' 2.tt |grep ftp > 3.tt
rm -rf ./1.tt ./2.tt

aria2c --conf-path=/home/ivo/aria2/aria2.conf  -i ./3.tt
rm 3.tt -rf
