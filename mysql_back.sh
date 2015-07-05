#!/bin/bash
#20150705 jyh mysql_backup
User=backup
Passwd=backup

Backdir=/home/backup
Date=$(date +%F)
Olddate=$(date -30d +%F)
Ftpdate=$(date -50d +%F)

Mysql=/usr/local/mysql
Myadmin=/usr/local/mysqladmin
Mydump=/usr/loacl/mysqldump
Socket=/tmp/mysql.mock

[ -d ${Backdir} ]||mkdir -p ${Backdir}
[ -d ${Backdir}/${Date} ]||mkdir -p ${Backdir}/${Date}
[ ! -d ${Backdir}/${Olddate} ]||rm -rf ${Backdir}/${Olddate}

for Dbname in mysql test haoniu
do
	${Mydump} --opt -u${User} -p${Passwd} -S ${Scoket} ${Dbname} |gzip >${Backdir}/${Date}/${Dbname}_${Date}.tar.gz
	echo "${Dbname} has been backup successfull."
	/bin/sleep 5
done

#put ftp
Host=192.168.199.214
Ftp_user=ftpuser
Ftp_pwd=ftppwd

cd ${Backdir}/${Date}

ftp -i -n -v << !
open ${Host}
user ${Ftp_user} ${Ftp_pwd}
bin
cd ${Ftpdate}
mdelete *
cd ..
rmdir ${Ftpdate}
mkdir ${Date}
cd ${Date}
mput *
bye
!

