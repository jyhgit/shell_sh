#!/bin/bash 
/bin/find /backup -type f -name "*.tar.gz" -mtime +180|xargs rm -f
