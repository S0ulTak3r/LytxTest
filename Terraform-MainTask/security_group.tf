/*
    These next 2 resources,
    create the security groups for both regions, 
    allowing Ping and SSM traffic between the 2 regions, and all outbound traffic
*/


# Region 1 Security Group
resource "aws_security_group" "security_group_region1" {
  provider = aws.region1 # a must to specify the provider for each resource, because we have 2 regions
  name        = "SecurityGroup-Region1"
  description = "Security group for Region 1"

  vpc_id = aws_vpc.vpc_1.id

  # Allow incoming ICMP traffic (ping) from the other region's VPC
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.vpc_2.cidr_block]
  }

  # Allow incoming traffic from AWS SSM in region 1
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allowing traffic from anywhere on port 443
  }

   # If you feel like it, you can add more ingress rules as needed but this is enough for now

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic (you can restrict this if needed)
  }

  depends_on = [aws_vpc.vpc_1]
}


# Region 2 Security Group
resource "aws_security_group" "security_group_region2" {
  provider = aws.region2 # a must to specify the provider for each resource, because we have 2 regions
  name        = "SecurityGroup-Region2"
  description = "Security group for Region 2"

  vpc_id = aws_vpc.vpc_2.id

  # Allow incoming ICMP traffic (ping) from the other region's VPC
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.vpc_1.cidr_block]
  }

  # Allow incoming traffic from AWS SSM in region 2
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allowing traffic from anywhere on port 443
  }

  # If you feel like it, you can add more ingress rules as needed but this is enough for now

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic (you can restrict this if needed)
  }

  depends_on = [aws_vpc.vpc_2]
}
