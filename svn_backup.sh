#!/bin/bash
#backup svn 
#20150705 jyh
SRCDIR=/svndata/
BACKDIR=/svndata/backup
Date=$(date +%F)
OLDDATE=$(date -v -30d +%F)
SVNADMIN=/usr/bin/svnadmin
Logfile=${BACKDIR}/svn_$Date.log
IP=ifconfig eth1|awk -F'[ :]+' '{print $4}'
[ -d ${BACKDIR} ] || mkdir ${BACKDIR}
[ -d ${BACKDIR}/${DATE} ]|| mkdir -p ${BACKDIR}/${DATE}

if [ -d ${BACKUP}/${OLDDATE} ];then
	rm -rf ${BACKUP}/${OLDDATE}
fi

echo " ">>${Logfile}
echo " ">>${Logfile}
echo "-------------------------------------------------">>${Logfile}
echo                    'date "+%F %T"'>>${Logfile}
echo "* * * subversion backup notification * * *">>${Logfile}
/usr/bin/printf "HOst:`hostname`\nAddress:${IP}\nDate:${Date}\n" >>${Logfile}


for project in svnhhy svnhaohuoyan svnhaomai svnwx
do
cd ${SRCDIR}
$svnadmin htcopy ${project} ${BACKDIR}/${Date}/${project} --clean-logs
cd ${BACKDIR}/${Date}
tar -zcf ${project}_svn_${Date}.tar.gz ${project}>/dev/null 
if [ $? == 0 ];then
rm -rf ${project}
fi

echo "Repository :${project} backup done into ${BACKDIR}/${Date}/ successful">>${Logfile}

#up ftp
Host=192.168.199.74
Ftp_user=svn_user
Ftp_passwd=svn_passwd

cd ${BACKDIR}/${Date}

ftp -i -n -v << !
open ${Host}
user ${Ftp_user} ${Ftp_passwd} 
bin
cd ${OLDDATE}
mdelete *
cd ..
rmdir ${OLDDATE}
mkdir ${Date}
cd ${Date}
mput *
bye
!

