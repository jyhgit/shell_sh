#!/bin/bash
#find /backup -type f -name "flag_$(date +%F)"|xargs md5sum -c |grep FAILED >/opt/mail_$(date +%F).txt
find /backup -type f -name "flag_$(date +%F)"|xargs md5sum -c  >/opt/mail_$(date +%F).txt

#if [ ! -f /opt/mail_$(date +%F).txt ] || [ -s /opt/mail_$(date +%F).txt ]
#	then
# 		echo "backup is error,pls view server ">>/opt/mail_$(date +%F).txt
                mail -s "$(date +%U%T) backup" 1808996884@qq.com </opt/mail_$(date +%F).txt
#fi
