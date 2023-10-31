/*
This is the VPC Creation File,
it create:
a custom VPC in 2 Regions, 
with 2 Subnets in each Region, 
an Internet Gateway in each Region,
a VPC Peering Connection between the 2 VPCs, 
and a Route Table for each VPC to allow communication between the 2 VPCs,
and the General Internet gateway for communication with the Internet.
*/


#Creates Vpc in region 1
resource "aws_vpc" "vpc_1" {
  provider = aws.region1 # a must to specify the provider for each resource, because we have 2 regions

  cidr_block = var.vpc_cidr_1
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = {
    Name = "VPC-1"
  }
}

#Creates Vpc in region 2
resource "aws_vpc" "vpc_2" {
  provider = aws.region2  # a must to specify the provider for each resource, because we have 2 regions

  cidr_block = var.vpc_cidr_2
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = {
    Name = "VPC-2"
  }
}

#Creates Subnet in region 1
resource "aws_subnet" "subnet_region1" {
  provider = aws.region1 # a must to specify the provider for each resource, because we have 2 regions

  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet-Region1"
  }
}

#Creates Subnet in region 2
resource "aws_subnet" "subnet_region2" {
  provider = aws.region2 # a must to specify the provider for each resource, because we have 2 regions

  vpc_id                  = aws_vpc.vpc_2.id
  cidr_block              = "10.1.1.0/24"
  availability_zone       = "il-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet-Region2"
  }
}

# Creates Internet Gateway in region 1
resource "aws_internet_gateway" "igw_region1" {
  provider = aws.region1 # a must to specify the provider for each resource, because we have 2 regions
  vpc_id = aws_vpc.vpc_1.id

  depends_on = [aws_vpc.vpc_1]
}

# Creates Internet Gateway in region 2
resource "aws_internet_gateway" "igw_region2" {
  provider = aws.region2 # a must to specify the provider for each resource, because we have 2 regions
  vpc_id = aws_vpc.vpc_2.id

  depends_on = [aws_vpc.vpc_2]
}



# The 2 Next Resources Create VPC Peering Connection between the 2 VPCs
resource "aws_vpc_peering_connection" "vpc_peering" {
  provider = aws.region1 # a must to specify the provider for each resource, because we have 2 regions

  vpc_id      = aws_vpc.vpc_1.id
  peer_vpc_id = aws_vpc.vpc_2.id
  peer_region = "il-central-1"

  tags = {
    Name = "VPC-Peering-1-2"
  }
}



resource "aws_vpc_peering_connection_accepter" "peer_accepter" {
  provider = aws.region2 # a must to specify the provider for each resource, because we have 2 regions

  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  auto_accept               = true

  tags = {
    Name = "VPC-Peering-1-2-Accepter"
  }
}

# The 2 Next Resources Create Route Tables for the 2 VPCs for the internet gateway
resource "aws_route" "internet_access_region1" {
  provider = aws.region1 # a must to specify the provider for each resource, because we have 2 regions
  route_table_id         = aws_vpc.vpc_1.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_region1.id
}

resource "aws_route" "internet_access_region2" {
  provider = aws.region2 # a must to specify the provider for each resource, because we have 2 regions
  route_table_id         = aws_vpc.vpc_2.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_region2.id
}

# The 2 Next Resources Create Route Tables for the 2 VPCs for the VPC Peering Connection
resource "aws_route" "route_vpc_1_to_vpc_2" {
  provider = aws.region1 # a must to specify the provider for each resource, because we have 2 regions

  route_table_id         = aws_vpc.vpc_1.main_route_table_id
  destination_cidr_block = aws_vpc.vpc_2.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}

resource "aws_route" "route_vpc_2_to_vpc_1" {
  provider = aws.region2 # a must to specify the provider for each resource, because we have 2 regions

  route_table_id         = aws_vpc.vpc_2.main_route_table_id
  destination_cidr_block = aws_vpc.vpc_1.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}
