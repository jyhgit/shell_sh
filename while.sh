#!/bin/bash
while read name pass uid gid gecos home shell
do
 echo $home
done </etc/passwd
