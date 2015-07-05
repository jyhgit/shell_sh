#!/bin/bash
for i in `cat a.txt`
do
	a=${a}" "${i}
done
echo $a
