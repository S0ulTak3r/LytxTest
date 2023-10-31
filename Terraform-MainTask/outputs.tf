# Outputs the VPC IDs

output "vpc_1_id" {
  value = aws_vpc.vpc_1.id
}

output "vpc_2_id" {
  value = aws_vpc.vpc_2.id
}
