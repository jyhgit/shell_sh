#!/bin/bash
#20150704 #author jyh
for n in {30..50};do
	host=192.168.199.$n
	ping -c2 $host &>/dev/null
	if [ $? = 0 ];then
		echo "$host is UP"
		echo "$host">>alive.txt
	else
		echo "$host is Down"
	fi
done
