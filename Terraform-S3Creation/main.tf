# Terraform version: 0.12.24

# Configure the AWS Provider for the global s3 statefile bucket
provider "aws" {
  region = "eu-north-1"
}

# Generate a random string for the bucket name suffix
resource "random_string" "bucket_suffix" {
  length  = 3
  special = false
}

# Create a S3 bucket for MAIN Terraform-Configuration statefile backend
resource "aws_s3_bucket" "terraform_state" {
  # Convert the random string to lowercase using the 'lower' function
  bucket = "terraform-state-${lower(random_string.bucket_suffix.result)}"
  # Give Tags to the bucket for better identification
  tags = {
    Name        = "TerraformStateBucket"
    Environment = "Production"
  }
}

# Enable versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.terraform_state.bucket

  versioning_configuration {
    status = "Enabled"
  }
}
