#!/bin/bash
#20150704 
while :
do
	nginx_count=`ps -C nginx --no-header|wc -l`
	if [ $nginx_count -eq 0 ];then
		ulimit -SHn 65535
		/usr/local/nginx/sbin/nginx
	sleep 5
		nginx_count=`ps -C nginx --no-header|wc -l`
		if [ $nginx_count -eq 0 ];then
		/etc/init.d/keepalived stop
		fi
	fi
sleep 5
done

	
			
