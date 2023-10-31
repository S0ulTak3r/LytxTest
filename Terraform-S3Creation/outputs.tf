# This file is used to output the values of the resources created

# Output the s3 bucket name and key path, for easy access
output "s3_bucket_name" {
    value       = aws_s3_bucket.terraform_state.bucket
    description = "The name of the S3 bucket"
}

output "s3_bucket_key_path" {
    value       = "state/terraform.tfstate"
    description = "The key path of the Terraform state file in the S3 bucket"
}