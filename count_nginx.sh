#!/bin/bash
#20150704 @author jyh
if [ $# -eq 0 ];then #判断参数是否为nginx文件
	echo "Error:please specify logfile."
	exit 0
else
	log=$1
fi

if [ ! -f $1 ];then
	echo "Sorry,sir,I cann't find access log"
	exit 0
fi

#################################################
echo "Most of the access ip:"
echo "------------------------------------------"
awk '{print $1}' $log|sort|uniq -c|sort -nr|head -10
echo
echo
################################################
echo "Most of the access time:"
echo "------------------------------------------"
awk '{print $4}' $log |cut -c 14-18|sort|uniq -c|sort -nr|head -10
echo
echo
###############################################
echo "Most of the page:"
echo "-----------------------------------------"
awk '{print $7}' $log |sed 's/^.*\(.cn*\)\"/\1/g'|sort|uniq -c|sort -nr|head -10
echo
echo
###############################################
echo "Most of the time/Most of the ip:"
echo "----------------------------------------"
awk '{print $4}' $log |cut -c 14-18|sort|uniq -c|sort -nr|head -10 >time.log

for i in `awk '{print $2}' time.log`
do
	num=`grep $i time.log|awk '{print $1}'`
	echo "$i $num"
	ip=`grep $i $log|awk '{print $1}'|sort|uniq -c|sort -nr|head -10`
	echo "$ip"
	echo
done
rm -f time.log
