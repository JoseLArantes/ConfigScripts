#!/bin/bash
# Give process name as parameter
# This example kills processes older than 1 hour

current_time=$(date +%s)
ps axo lstart=,pid=,cmd= |
    grep $1 |
    while read line
    do
        if (( $(date -d "${line:0:25}" +%s) < current_time - 60 ))
        then
#            echo $line | cut -d ' ' -f 6
	    kill -9 $line
        fi
    done
