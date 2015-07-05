#!/bin/bash
#20150704 jyh
CSVDIR=/home/www/csv
DATE=`date +%Y-%m-%d`
OLDDATE=`date -v -10d +%Y-%m-%d`

BACKDIR=/data/backup
FILENAME=csvbackup_${DATE}

if [ ! -d ${BACKDIR}/${DATE} ];then
	mkdir ${BACKDIR}/${DATE}
fi


if [  -d ${BACKDIR}/${OLDDATE} ];then
	rm -rf ${BACKDIR}/${OLDDATE}
fi

HOST=127.0.0.1
FTP_USER=ftpuser
FTP_PASSWD=ftppasswd

cd $BACKVDIR
tar -zcf $FILENAME.tar.gz $CSVDIR

ftp -i -n -v << !
open ${HOST}
user ${FTP_USER} ${FTP_PASSWD}
bin
rmdir ${OLDDATE}
mkdir ${DATE}
cd ${DATE}
mput *
bye
!
