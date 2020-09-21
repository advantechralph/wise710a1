#!/bin/bash
  
settime=40
pslog=/root/LOG/ps.log
systemctllog=/root/LOG/systemctl.log
systemstatuslog=/root/LOG/systemstatus.log
ctfile=/root/CONFIG/ct.txt
loop=$(awk '{print int($1)}' $ctfile)
loop=${loop:-0}
mkdir -p /root/{CONFIG,LOG}
echo "=================" >> $pslog
echo "=================" >> $systemctllog
echo "=================" >> $systemstatuslog
while : 
do
  uptime=$(awk '{print int($1)}' /proc/uptime)
  if [ $uptime -gt $settime ] ; then
    loop=$(( $loop + 1 ))
    echo $loop > $ctfile
    sync
    #systemctl reboot
    #strace -o /root/strace.log /sbin/init 6
    #/sbin/init 6
    #systemctl -f reboot
    /sbin/init 6
    #/usr/Advantech/EAPI_test/testdl_wdt -s 1
    exit 0;
  fi
  date >> $pslog
  ps ax >> $pslog
  date >> $systemctllog
  systemctl >> $systemctllog
  date >> $systemstatuslog
  systemctl status >> $systemstatuslog
  sleep 3
done

