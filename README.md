Hey,
this is a the project, that Lytx gave me to complete.

the mission was:
Your task, should you choose to accept it!

 

Main Objective:

·         there are companies in 2 different regions of the globe (in AWS).

·         each company needs a single ec2 instance

·         each instance must be able to ping the other instance

·         these computers should only be accessible by using AWS SSM in the AWS Console

 

Deliverable:

·         Terraform code which deploys the complete infrastructure described above

·         Screenshots of any behavior to show proof of connectivity

 

 

 

Bonus Objective:

·         a github repository for this code, in which a merge to the main branch triggers a deployment of the entire infrastructure to the AWS account, using secrets from within that repository and github actions

 

Rules:

 

·         This task is limited to 3 hours there is no limit to the type of resources for this task. 

 

·         The areas to focus on, weighted in this order:

·         security

·         simplicity

·         documentation

·         code quality

 

Please send an email with the deliverable when completed to stop the clock on this task.

 

Note
1. The point of this exam is to see how far someone can get in 3 hrs. The expectation is that the knowledge to get further than what was included in this exam would be completed in the allotted time. 
2. there is no question that anyone in DevOps with enough time can solve this exam, but we are looking for someone who is completely knowledgeable to complete this entire task within 3 hrs because there are much more complex tasks that we will require.

 

Good Luck!

Dan


Solution:

Before we start with actually giving a solution, to the mission described above we need to make sure, certain pre-requirements are present so we will be able to procceed.


1. 
We need to ensure, we have set up a Dev enviornment where we will be working on (Can be your local computer (i have windows), but i always prefer to have a VM of Linux for Dev purposes)

After we have set up an enviorment, either Local or Virtual we will ensure that our enviornment has the neccessery tools installed.

1.1 AWS-CLI, so we will be able to interact with AWS Console from the command line, this is a very important step, we wont configure it for now with aws configure.
aswell as terraform needs it to operate on the cloud, it will serve as credentials when we will init, and apply the terraform (he will use the configure access key that we will create later.)

1.2 TerraForm, we just ensure we have a stable version of terraform installed on the enviornment (i have an ansible script that automatically pulls the latest version for my liking)

1.3 Git, for later git operations.

1.4 Any Other Software/Tool you see fit to accomplish this task

2.
Okay great we have set up a enviornment with all the tools installed,
now we will move to the cloud, and make a couple of configurations for the operations and security for this task.

2.1 we will create a group and name it Administrators (you can name it wathever you like, but something relevant to the actual purpose)

and attach the group with the following policies:


AdministratorAccess--> Optional but not recommended i DID NOT use it.

AmazonEC2FullAccess--> we do need the users of this group to be able to configure ec2 instances.

AmazonS3FullAccess--> we need it to configure a bucket, that will serve as the terraform state file, general backend location.

AmazonSSMFullAccess--> will grant the user to operate in the SSM space

AmazonVPCFullAcccess--> as we will be creating a personal customized VPC networking

IAMFullAccess--> as we will be creating an IAM Role for the instances to allow SSM.

(Quick Note: we can of course create a custom AWS Policy, with even stricter security reasoning, but for the ease of the task we will use AWS already created policies)



2.2 Great, now when the group is configured, we will create an IAM User (we wont work from the root, as for clear security breach reasons)

We will create a user, IAM User, and not the other option as well, im not working with active directory or other directories for user management as i dont have a big company at home, but for companies, i guess they will most likely use the Identity Center.

okay so in the IAM User, we will give him a password, add him to the group, and finish the user creation.

Great now we have a user that will operate as our Agent for this task.

2.3 we will enter the user profile from IAM, navigate to Security Credentials of the user we created.
go down to Access Keys, and create an access key.

Great amazing, now we will use this key to Configure AWS-CLI in our Dev Enviornment and we can start working on our task, by creating the terraform product.


3. we go back to the Dev enviornment, and enter: AWS CONFIGURE.

we configure a specific user on the enviornment (on linux) and then configure aws credentials of the user we created in the IAM, meaning the linux user and everything he will create that will need access to AWS will use the Access Key, of the user we created before, thus giving him access to the policies and permissions we have configured before.


3.1 okay, now we need to ensure we have a s3 bucket to serve as a terraform statefile location for the backend, we have alot of options, but as i like to automate as much as possible in code, i will use a script i have created before to ease me for this task.

we will create a main folder for the task, and 2 sub folder.

1 sub folder--Responsible for 1-Run s3 bucket creation, and then we will never use it again, unless we will want to create a s3 bucket again from scratch. (the script is in terraform form, the statefile will be local but as i stated again, this is only for creating a s3 bucket, and then we will never run this again, unless we will want to recreate the same enviornment on another aws account)

so great, sub folder 1, will create the s3 bucket.


GREAT, we are finished, we can procceed we actually creating the TerraForm files if sub folder 2 that will actually be the MAIN folder of this task, and will contain different .tf files for the purpose of this task, and at the end we can apply it and it will work.

(NOTE: REMEMBER subfolder 1 is meant to be run only once with terraform apply, you will never use it again, its just for easy automatic configuration of a bucket, for statefile saving, of course you can do this manually but heck why not automate it. ) 