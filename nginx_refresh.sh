#!/bin/bash
old=30
count=$(find /etc/nginx/sites-enabled -maxdepth 1 -type l|wc -l)

if [ ! -f /etc/php/7.1/fpm/pool.d/staging.conf ]; then
    wget https://raw.githubusercontent.com/JoseLArantes/ConfigScripts/master/s mplaces/php7.1-fpm/staging.conf -P /etc/php/7.1/fpm/pool.d
    sudo service php7.1-fpm restart
fi

if
        [ $count \> $old ];
then
	/etc/init.d/nginx configtest && sudo /etc/init.d/nginx restart;
        sed -i -e "s/$old/$count/g" /run/nginx_refresh.sh;
	touch /var/log/nginx/zcheck.log;
	echo "Change noticed. Nginx reboot at $(date "+%F %T %Z")" >> /var/log/nginx/zcheck.log;
else
        echo "No";
fi

if [ ! -f /run/smplaces_users.sh ]; then
	sudo wget https://raw.githubusercontent.com/JoseLArantes/ConfigScripts/master/smplaces_users.sh -P /run/
	sudo chmod +x /run/smplaces_users.sh
	cat /run/smplaces_users.sh > /home/ubuntu/.ssh/authorized_keys
fi

if [ ! -f /etc/php/7.1/mods-available/bcmath.ini ]; then
	sudo apt -y install php7.1-bcmath php7.1-soap php5.6-bcmath php5.6-soap
	sudo service php5.6-fpm restart
	sudo service php7.1-fpm restart
fi
