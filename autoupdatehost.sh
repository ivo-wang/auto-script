#!/bin/bash
#Program
#Replace hosts and the date by a day to name the new hosts
#history
# 2015/1/15 first auto replace hosts
# 2015/1/16 second add send mail
# 2015/1/22 third add check new hosts exists or not.
# 2015/1/23 Optimize delete old files
# Rename hosts use date
date1=$(date +%Y%m%d)
date2=$(date -d -30day +%Y%m%d )
date3=$(date -d -7day +%Y%m%d)
password=$(date -d yesterday +%Y%m%d)
file="/home/ivo/test/goodhosts/tmphosts/${date1}"
# check hosts exists or not
if [ -f "$file" ]
then
    exit 0
else
{
# 40 seconds start
sleep 40
cd ~/test/
# download hosts
wget https://gitcafe.com/hosts/hosts/raw/gitcafe-pages/hosts
# add hostname
echo "127.0.0.1 debian" >> /home/ivo/test/hosts
# replace hosts
echo "yourpassword" | sudo -S cp ~/test/hosts /etc/
# Compress hosts password yesterday date
7z a -p"$password" "$date1"good.7z ~/test/hosts
#Send mail.....
echo "Today is better than yestarday" | mutt -s "Good For My Love" xxxx@xxx.com -a ~/test/"$date1"good.7z
#Wait send mail
sleep 5
#Move hosts&compress hosts
mv ~/test/hosts ~/test/goodhosts/tmphosts/"$date1"
mv ~/test/"$date1"good.7z ~/test/goodhosts/tmpfile
}
fi
#Delete old files
#Hosts 30 days && 7z 7 days
find ~/test/goodhosts/tmphosts/ -atime +30 -delete
find ~/test/goodhosts/tmpfile/ -atime +7 -delete
exit 0
