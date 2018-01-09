#!/bin/bash
sudo service php5.6-fpm restart
sudo service nginx stop
sleep 10
sudo service nginx start
