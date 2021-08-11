#!/bin/bash
#Search on all repos on the repos folder

ls repos/ >> list_of_repos.txt
while read repo; do
    if [ ! -z "$1" ]
    then
        cd repos/$repo
        echo "Search $1 on repo: $repo"
        git rev-list --all | (while read rev; do git grep -e $1 $rev; done)
        cd ../../
    else
        echo "You need to enter the string to search"
    fi
done < list_of_repos.txt

rm list_of_repos.txt
