#!/bin/bash
# Give the instance id as parameter to search of it on all aws regions
# Considering configuration with proper permissions

if [ ! -z $1  ]
then
    for region in `aws ec2 describe-regions\
     --all-regions --query "Regions[].{Name:RegionName}" --output text`
    do
      echo -e "\nListing Instances in region:'$region'..."
      aws ec2 describe-instances --instance-id $1 \
      --region $region
    done
else
    echo "You need to give the instance id as parameter"
fi
