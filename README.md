# AWS Infrastructure Setup with Terraform

## Introduction

This document outlines the process of setting up an AWS environment to meet the requirements of a project provided by Lytx. The main objectives are to create two EC2 instances in different AWS regions, ensure they can ping each other, and make them accessible exclusively via AWS SSM.

## Pre-requisites

Before proceeding, ensure that your development environment is ready. This could be your local machine or a virtual machine running Linux.

### Required Tools

1. **AWS CLI**: To interact with AWS services via the command line. This is crucial as Terraform will use it to apply configurations.
2. **Terraform**: Ensure a stable version is installed.
3. **Git**: For version control and interaction with GitHub.
4. Any other tools you find necessary for this task.

## AWS Configuration

### Step 1: IAM Group and User Setup

1. **Create an IAM Group** named 'Administrators' (or a relevant name of your choice).
   - Attach the following policies (Note: You can use custom policies for stricter security):
     - AmazonEC2FullAccess
     - AmazonS3FullAccess
     - AmazonSSMFullAccess
     - AmazonVPCFullAccess
     - IAMFullAccess (Optional)

2. **Create an IAM User** and add it to the 'Administrators' group. Ensure to generate an Access Key for this user.

### Step 2: Configure AWS CLI

On your development environment, run `aws configure` and input the Access Key and Secret Key of the IAM user created in the previous step.

## Terraform Setup

### Step 3: S3 Bucket for Terraform State

1. **Create a main project folder** and two subfolders.
2. **First Subfolder**: This will contain Terraform scripts to create an S3 bucket for storing Terraform state files. Run `terraform apply` in this folder once to create the bucket. You won't need to use this again unless creating a new environment.

### Step 4: Main Terraform Configuration

1. **Second Subfolder**: This will be the main folder for your project, containing various `.tf` files for different parts of the infrastructure.
2. **Apply Terraform**: Once all configurations are set, run `terraform apply` to create the infrastructure.

---

**Note**: The first subfolder is meant for one-time use to set up the S3 bucket. After running `terraform apply` once in that folder, all further interactions should be in the second subfolder with the main Terraform configurations.
