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


**Example Requirement:**
Create an EC2 Instance
Attach public IP address.
Root device size is 30 GB.
On termination, disk cloud not delete.
Configuration:

resource "aws_instance" "myvm" {
  ami                         = "ami-03a6eaae9938c858c"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  root_block_device {
    volume_type           = "gp2"
    volume_size           = "30"
    delete_on_termination = false
  }
  tags = {
    Name = "MyVM"
  }
}

output "IPAddress" {
  value = "${aws_instance.myvm.public_ip}"
}

Initialize Terraform:
Run the following command to initialize Terraform in the directory containing your main.tf file.
$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v5.19.0...
- Installed hashicorp/aws v5.19.0 (signed by HashiCorp)


Create an Execution Plan:
Run the following command to create an execution plan.
$ terraform plan
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.myvm will be created
  + resource "aws_instance" "myvm" {
      + ami                                  = "ami-03a6eaae9938c858c"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
Apply the Configuration:
Once you're satisfied with the plan, apply the configuration to create the EC2 instance.
$ terraform apply --auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.myvm will be created
  + resource "aws_instance" "myvm" {
      + ami                                  = "ami-03a6eaae9938c858c"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = true
      + availability_zone                    = (known after apply)

Plan: 1 to add, 0 to change, 0 to destroy.
aws_instance.myvm: Creating...
aws_instance.myvm: Still creating... [10s elapsed]
aws_instance.myvm: Still creating... [20s elapsed]
aws_instance.myvm: Creation complete after 29s [id=i-04a8c9a82bdd397f8]

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

IPAddress = "44.207.3.81"



### User Data:

The "user_data" attribute allows you to add a bootstrap script or commands to an EC2 instance.
Scripts entered as user data are executed as the "root" user, so do not use the sudo command in the script.




### Destroy Resource:
If you want to remove the resources created by Terraform, you can use the `terraform destroy` command:
$ terraform destroy --auto-approve
aws_key_pair.deployer: Refreshing state... [id=deployer-key]
aws_instance.myvm: Refreshing state... [id=i-0e7bf9888abb9c19c]


