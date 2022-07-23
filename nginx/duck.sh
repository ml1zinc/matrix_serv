#!/bin/sh
myIP=`curl -s ifconfig.me`
retVal=$?
if [ $retVal -ne 0 ]; then
    myIP=`curl -s ident.me`
fi
retVal=$?
if [ $retVal -ne 0 ]; then
    myIP=`curl -s ipinfo.io/ip`
fi
#echo $myIP
curl -k -o /duckdns/duck.log 'https://www.duckdns.org/update?domains=${PREFIX_SERVER_NAME}&token=${DNS_TOKEN}&ip='${myIP}
