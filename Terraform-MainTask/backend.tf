terraform {
  backend "s3" {
    bucket  = "terraform-state-x5i"  # Replace This With Your Bucket Name, Created in SUB-FOLDER Terraform-S3Creation
    key     = "state/terraform.tfstate"  # A Key is the Path to the State File, in the Bucket Use the Same Path given in SUB-FOLDER Terraform-S3Creation
    region  = "eu-north-1" # The Region of the Bucket, Created in SUB-FOLDER Terraform-S3Creation, will serve as a global state
    encrypt = true 
  }
}


/*
    Note: Key is the Path to the State File, in the Bucket Use the Same Path given in SUB-FOLDER Terraform-S3Creation,
          Although, you can decide to use any path here, doesnt really matter, just make the path consistent and logical.

    Note: The Bucket Name is the Name of the Bucket Created in SUB-FOLDER Terraform-S3Creation,
          The Bucket Name MUST be exactly the name of the bucket created in SUB-FOLDER Terraform-S3Creation.
*/