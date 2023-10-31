#!/bin/bash

# Get the list of all available AWS regions
REGIONS=$(aws ec2 describe-regions --query "Regions[*].RegionName" --output text)

# Loop over each region and run the describe-instances command
for region in $REGIONS; do
  echo "Instances in region: $region"
  instances=$(aws ec2 describe-instances --region "$region" \
    --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`].Value | [0], InstanceId, State.Name]' \
    --output table)
  
  if [ "$instances" ]; then
    echo "$instances"
  else
    echo "No instances found"
  fi
  echo "-----------------------------------"
done
