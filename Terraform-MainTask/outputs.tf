# Outputs the VPC IDs
output "vpc_1_id" {
  value = aws_vpc.vpc_1.id
  description = "The ID of the first VPC"
}

output "vpc_2_id" {
  value = aws_vpc.vpc_2.id
  description = "The ID of the second VPC"
}

# Outputs the EC2 Instances IDs
output "ec2_instance_1_id" {
  value = aws_instance.instance_region1.id
  description = "The ID of the first EC2 instance"
}

output "ec2_instance_2_id" {
  value = aws_instance.instance_region2.id
  description = "The ID of the second EC2 instance"
}

# Outputs the EC2 Instances Public IPs
output "ec2_instance_1_public_ip" {
  value = aws_instance.instance_region1.public_ip
  description = "The public IP of the first EC2 instance"
}

output "ec2_instance_2_public_ip" {
  value = aws_instance.instance_region2.public_ip
  description = "The public IP of the second EC2 instance"
}

# Outputs the Security Groups IDs
output "security_group_1_id" {
  value = aws_security_group.security_group_region1.id
  description = "The ID of the first security group"
}

output "security_group_2_id" {
  value = aws_security_group.security_group_region2.id
  description = "The ID of the second security group"
}
