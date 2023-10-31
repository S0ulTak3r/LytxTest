# To understand what each variable stands for, please refer to description of each variable
# The value of each variable will be automatically filled using the terraform.auto.tfvars file

variable "aws_region_1" {
  description = "AWS region for the first location"
  type        = string
}

variable "aws_region_2" {
  description = "AWS region for the second location"
  type        = string
}

variable "vpc_cidr_1" {
  description = "CIDR block for the VPC in the first region"
  type        = string
}

variable "vpc_cidr_2" {
  description = "CIDR block for the VPC in the second region"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ssm_role_name" {
  description = "IAM Role name for SSM"
  type        = string
}
