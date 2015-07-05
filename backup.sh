#!/bin/bash
#20150705 jyh
# 命令最好在终端确认过，防止误写错命令

Date=$(date +%F)
IP=$(ifconfig eth1|awk -F '[ :]+' 'NR==2 {print $4}')
Path="/backup/$IP"
[ ! -d $Path ] && mkdir $Path -p

#backup
#cd / && \
cd /
tar -zcf $Path/www_$Date.tar.gz var/html/www/ &&\
tar -zcf $Path/config_$Date.tar.gz etc/rc.local etc/sysconf root/shell &&\
tar -zcf $Path/logs_$Date.tar.gz var/logs/ &&\
find $Path -type f -name "*$Date.tar.gz"|xargs md5sum >$Path/flag_$Date
#md5sum -c flag 自动检查 

#to back server
rsync -avz /backup/ rsync_backup@192.168.33.12::backup --password-file=/etc/rsync.password

#del
find /backup -type -f -name "*.tar.gz" -mtime +15|xargs rm -f
