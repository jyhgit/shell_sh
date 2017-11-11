#!/bin/bash
rpm -qa|grep tsar||rpm -ivh http://code.taobao.org/p/tsar/file/1800/tsar-2.1.0-0.el4.x86_64.rpm http://code.taobao.org/p/tsar/file/1801/tsar-devel-2.1.0-0.el4.x86_64.rpm 2>&1 >>/dev/null
tsar --help>>/dev/null 2>&1
if [ $? = 0 ];then
  nginxprocess=$(ps aux|grep nginx|grep -v 'grep'|wc -l)
  if [ $nginxprocess -gt 1 ];then
      cd /tmp/
      tsardevel nginx && cd nginx
      mv mod_nginx.c{,_bak}
      wget -q http://yum.jollycorp.com/script/mod_nginx.c  >>/dev/null && make >>/dev/null && make install >>/dev/null
      [ -f  /usr/local/tsar/modules/mod_nginx.so ] && echo 'nginx modul install sucess' || echo 'nginx module error';exit 1
  fi
else
  echo "tsar install fail"
  exit 1
fi
