

/*
    Create IAM Role for SSM, Enable ec2 attachment to this Role, and attach the AmazonSSMManagedInstanceCore policy to it
    This will allow the ec2 instances to communicate with the SSM service

    Note: The AmazonSSMManagedInstanceCore policy is a managed policy, 
          so we dont need to create it, we just need to attach it to the role

    Note: The policy written below is to enable the EC2 instances to assume the role we will create
*/

resource "aws_iam_role" "ssm_role" {
  # name of the role, that he pulls from the variables.tf file, that was populated by the terraform.auto.tfvars file
  name = var.ssm_role_name

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})

  # adds an additional tag to the role
  tags = {
    Name = var.ssm_role_name
  }
}

# This will attach the AmazonSSMManagedInstanceCore policy to the role we created above
resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ssm_role.name
}

# This will create an instance profile for the role we created above
resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = aws_iam_role.ssm_role.name
  role = aws_iam_role.ssm_role.name
}
