                                           Create VM's AWS Cloud

Creating virtual machines (VMs) in AWS using Terraform involves defining your infrastructure and then applying those configurations to provision the VMs.

### Prerequisites:

1. You need an AWS account with appropriate permissions to create resources.
2. Install and configure the AWS CLI on your local machine for authentication.
Define VM Configuration:
Create a main.tf to define your infrastructure. 



### To create an EC2 instance,  """ami and instance_type"""  are the mandatory arguments.

### There are other arguments such as:


**
availability_zone
key_name
security_group
subnet_id
user_data
tenancy
associate_public_ip_address
network_interface
tags
Also, it has block device arguments such as:
volume_type
volume_size
iops
delete_on_termination
encrypted

**





### User Data:

The "user_data" attribute allows you to add a bootstrap script or commands to an EC2 instance.
Scripts entered as user data are executed as the "root" user, so do not use the sudo command in the script.




### Destroy Resource:
If you want to remove the resources created by Terraform, you can use the `terraform destroy` command:
$ terraform destroy --auto-approve
aws_key_pair.deployer: Refreshing state... [id=deployer-key]
aws_instance.myvm: Refreshing state... [id=i-0e7bf9888abb9c19c]


