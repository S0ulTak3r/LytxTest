# Variables

# Region-1
aws_region_1   = "eu-north-1"

# Region-2
aws_region_2   = "il-central-1"

# VPC-Cidr-1
vpc_cidr_1     = "10.0.0.0/16"

# VPC-Cidr-2
vpc_cidr_2     = "10.1.0.0/16"

# Instance Type that will be used in each region (Needs to be in-common between regions, make sure it's available in both regions)
instance_type  = "t3.micro"

# IAM Role name that we will create for global use for the SSM operations on the EC2 instances.
ssm_role_name  = "SSMRole"
