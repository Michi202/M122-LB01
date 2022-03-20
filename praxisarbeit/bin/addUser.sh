#!/bin/bash
while IFS=: read username fullname usergroups
do
	getent group $usergroups || groupadd $usergroups
   	useradd -m -k /etc/skel -G $usergroups -c "$fullname" $username
   	passwd -e
done < username.txt