#!/bin/bash
old=30
count=$(find /etc/nginx/sites-enabled -maxdepth 1 -type l|wc -l)

if
        [ $count \> $old ];
then
	/etc/init.d/nginx configtest && sudo /etc/init.d/nginx reload;
        sed -i -e "s/$old/$count/g" /etc/nginx/sites-available/zcheck_nginx_changes_on_infrastructure.sh;
	touch /var/log/nginx/zcheck.log;
	echo "Change noticed. Nginx reboot at $(date "+%F %T %Z")" >> /var/log/nginx/zcheck.log;
else
        echo "No";
fi
