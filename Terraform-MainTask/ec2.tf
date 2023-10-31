# Terraform code to create EC2 instances in two different regions

# Creates an EC2 instance in region 1 with all required configurations and tags
resource "aws_instance" "instance_region1" {
  ami           = "ami-0df024d681444bc53" # AMI Specific to eu-north-1 amazon-linux -> we use this because SSM Agent is pre-installed
  instance_type = var.instance_type # t3.micro
  subnet_id     = aws_subnet.subnet_region1.id
  vpc_security_group_ids = [aws_security_group.security_group_region1.id]
  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name

  provider = aws.region1 # a must to specify the provider for each resource, because we have 2 regions
  tags = {
    Name = "LYTX-Instance-Region1"
  }
}

# Creates an EC2 instance in region 2 with all required configurations and tags
resource "aws_instance" "instance_region2" {
  ami           = "ami-01d00cfa9386bd907" # AMI Specific to il-central-1 amazon-linux -> we use this because SSM Agent is pre-installed
  instance_type = var.instance_type # t3.micro
  subnet_id     = aws_subnet.subnet_region2.id
  vpc_security_group_ids = [aws_security_group.security_group_region2.id]
  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name

  provider = aws.region2 # a must to specify the provider for each resource, because we have 2 regions
  tags = {
    Name = "LYTX-Instance-Region2"
  }
}
