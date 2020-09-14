#!/bin/bash
#require netcat installed

if [ $# -ne 2 ];then
	echo "Usage: $0 server_fqdn port (514 / 162)"
	exit 1
fi

#TEST PING - If server not alive print "fail" and quit 
line=$(ping ${1} -c 1 -s 1 -W 1| egrep "100% packet loss"| wc -l)
if [ "$line" != "0" ];then
	#echo "$1 no response, please check the host & firewall rule!"
	echo -n "fail"
	exit 0
fi


#TEST PORT - If server is alive we check if the port is open - if not print "fail" and quit 
IP=$(/usr/bin/dig +short ${1})
if [ $2 -eq "514" ] || [ $2 -eq "162" ]; then
	ret=$(/bin/nc -unvz -w 1 ${IP} ${2} 2>&1 | egrep 'open'& > /dev/null)
elif [ $2 -eq "1062" ]; then
	ret=$(/bin/nc -nvz -w 1 ${IP} ${2} 2>&1 | egrep 'open'& > /dev/null)
fi
if [ $? -ne 0 ] || [ "$ret" = "" ]; then
	echo -n "fail"
	exit 0
#else
#	echo -n "success"
fi


#TEST SERVICE RUNNING - If server is alive we check if the port is open - if not print "fail" and quit 
if [ $2 -eq "514" ]; then
	service="syslog-ng.service"
elif [ $2 -eq "162" ]; then
	service="snmptrapd.service"
elif [ $2 -eq "1062" ]; then
	service="logstash.service"
fi
run=$(ssh gobetween@${1} "systemctl status ${service}"  2>&1 | grep 'active (running)'| wc -l)
if [ $? -ne 0 ] || [ "$run" -eq "0"  ]; then
	echo -n "fail"
else
	echo -n "success"
fi

#Quit in all case
exit 0

