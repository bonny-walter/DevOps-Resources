### Example 1: Conditionally Create an EC2 Instance

# Variable to control resource creation
variable "create_ec2" {
  description = "Set to true to create the EC2 instance"
  type        = bool
  default     = false
}

# EC2 instance resource
resource "aws_instance" "example" {
  count         = var.create_ec2 ? 1 : 0
  ami           = "ami-0c55b159cbfafe1f0" # Example AMI
  instance_type = "t2.micro"

  tags = {
    Name = "Conditional-Instance"
  }
}

    If create_ec2 is true, the instance is created; otherwise, no resource is created.

### Example 2: Conditionally Create an S3 Bucket

# Variable to control resource creation
variable "create_s3_bucket" {
  description = "Set to true to create the S3 bucket"
  type        = bool
  default     = true
}

# S3 bucket resource
resource "aws_s3_bucket" "example" {
  count = var.create_s3_bucket ? 1 : 0

  bucket = "my-conditional-bucket-${random_string.suffix.result}"
  acl    = "private"

  tags = {
    Environment = "Dev"
    Name        = "Conditional Bucket"
  }
}

# Random string for unique bucket name
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

### Example 3: Conditionally Add Security Groups to an Instance

# Variable to control security group attachment
variable "use_custom_sg" {
  description = "Set to true to use a custom security group"
  type        = bool
  default     = false
}

# Default security group
data "aws_security_group" "default" {
  name = "default"
}

# Conditional security group
resource "aws_security_group" "custom" {
  count = var.use_custom_sg ? 1 : 0

  name        = "custom-sg"
  description = "Custom security group"
  vpc_id      = "vpc-12345678"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance with conditional SG assignment
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  security_groups = var.use_custom_sg ? 
    [aws_security_group.custom[0].name] : 
    [data.aws_security_group.default.name]

  tags = {
    Name = "Conditional-SG-Instance"
  }
}

### Example 4: Conditional Logic in Modules

You can use conditionals when passing arguments to modules:

# Variable for enabling/disabling logging
variable "enable_logging" {
  description = "Enable S3 bucket logging"
  type        = bool
  default     = false
}

# Module call with conditional argument
module "s3_bucket" {
  source = "./modules/s3"

  logging = var.enable_logging ? {
    target_bucket = "logging-bucket"
    target_prefix = "logs/"
  } : null
}

### Example 5: Conditionally Manage Multiple Resources with for_each

# List of enabled resources
variable "enabled_services" {
  type    = list(string)
  default = ["s3", "ec2"]
}

# Define resource configurations
locals {
  services = {
    s3  = { bucket_name = "example-bucket" }
    ec2 = { ami = "ami-0c55b159cbfafe1f0", instance_type = "t2.micro" }
  }
}

# Conditionally create resources
resource "aws_s3_bucket" "buckets" {
  for_each = { for service, config in local.services : service => config if service == "s3" && contains(var.enabled_services, service) }

  bucket = each.value.bucket_name
  acl    = "private"
}

resource "aws_instance" "instances" {
  for_each = { for service, config in local.services : service => config if service == "ec2" && contains(var.enabled_services, service) }

  ami           = each.value.ami
  instance_type = each.value.instance_type
}

