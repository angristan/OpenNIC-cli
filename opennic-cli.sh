#!/bin/bash
if [ "$UID" -ne "0" ] #User check
then
   echo -e "Use this script as root."
   exit
else
#Getting the nearest OpenNIC servers using the geopi API
read ns1 ns2 <<< $(curl -s https://api.opennicproject.org/geoip/ | head -2 | awk '{print $1}')
chattr -i /etc/resolv.conf #Allow the modification of the file
sed -i 's|nameserver|#nameserver|' /etc/resolv.conf #Disable previous DNS servers
echo -e "nameserver $ns1
nameserver $ns2" >> /etc/resolv.conf #Set the DNS servers
chattr +i /etc/resolv.conf #Disallow the modification of the file
fi
