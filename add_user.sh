#!/bin/bash
#20150704 jyh
for name in tom lilei yuehan
do
	useradd $name
	echo redhat|passwd --stdin $name
done
