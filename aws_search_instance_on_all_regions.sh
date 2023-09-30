#!/bin/bash
# Give the instance id as parameter to search of it on all aws regions
# Considering configuration with proper permissions

# USING OKTA search on all accounts

# echo "Enter the profile name or All to search in all profiles"
# read profiliesearch

# for profile in $(aws-okta list | awk '{print $1;}' | sed '/[PROFILE]/d'); do

for profile in $(aws-okta list | awk '{print $1;}' | sed '/[PROFILE]/d'); do
  echo "Search on profile $profile"
  if [ ! -z $1  ] && [ $profile != "gov" ]
  then
      for region in `aws-okta exec $profile -- aws ec2 describe-regions\
      --all-regions --query "Regions[].{Name:RegionName}" --output text`
      do
        echo -e "\nListing Instances in region:'$region'..."
        aws-okta exec $profile -- aws ec2 describe-instances \
            --filters Name=tag-key,Values=Name \
            --query 'Reservations[*].Instances[*].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Name:Tags[?Key==`Name`]|[0].Value}' \
            --output table | grep $1
      done
  else
      echo "You need to give the instance id as parameter"
  fi
done





#!/bin/bash
# Give the instance id as parameter to search of it on all aws regions
# Considering configuration with proper permissions

# USING OKTA search on all accounts
#echo "Enter the string you want to search"
#read searchfor
#echo "Enter the profile name or All to search in all profiles"
#read profilesearch
#
#if [[ $profilesearch = "All" ]]
#then
#	command1="aws-okta list";
#	command2="awk '{print \$1;}'";
#	command3="sed '/[PROFILE]/d'";
#else
#	command1="aws-okta list";
#	command2="awk '{print \$1;}'";
#  command3="grep $profilesearch";
#fi
#echo "$profilesearch"
#command="$command1 "\|" $command2 "\|" $command3"
#
#for profile in $($command); do
#  echo "Search on profile $profile"
##  aws-okta exec "$profile" -- bash -l
#  if [ ! -z $1  ] && [ $profile != "gov" ]
#  then
#      for region in `aws-okta exec $profile -- aws ec2 describe-regions\
#      --all-regions --query "Regions[].{Name:RegionName}" --output text`
#      do
#        echo -e "\nListing Instances in region:'$region'..."
#        aws-okta exec $profile -- aws ec2 describe-instances \
#            --filters Name=tag-key,Values=Name \
#            --query 'Reservations[*].Instances[*].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Name:Tags[?Key==`Name`]|[0].Value}' \
#            --output table | grep $searchfor
#      done
#  else
#      echo "You need to give the instance id as parameter"
#  fi
#done
