#!/bin/bash
#20150704 jyh
for pid in `ps aux|grep nginx|grep -v grep|awk '{print $2}'`
do
	cat /proc/${pid}/limits|grep 'Max open file'
done

