#!/bin/sh
# Parameter 1 User of the process
# Parameter 2 Process name
find /proc -maxdepth 1 -user $1 -type d -mmin +300 -exec basename {} \; \
| xargs ps | grep $2 | awk '{ print $1 }' | sudo xargs kill
