#!/bin/bash

# Get the list of all available AWS regions
REGIONS=$(aws ec2 describe-regions --query "Regions[*].RegionName" --output text)

# Initialize variables to store regions with and without instances
regions_with_instances=""
regions_without_instances=""

# Loop over each region and run the describe-instances command
for region in $REGIONS; do
  instances=$(aws ec2 describe-instances --region "$region" \
    --query 'Reservations[*].Instances[*].[InstanceId, Tags[?Key==`Name`].Value | [0], State.Name]' \
    --output table)
  
  if [ "$instances" ] && [ "$instances" != "None" ]; then
    regions_with_instances+="\nInstances in region: $region\n$instances\n\n"
  else
    regions_without_instances+="$region "
  fi
done

# Output the results
echo -e "Regions with Instances: $regions_with_instances"
echo "Regions without Instances: $regions_without_instances"
