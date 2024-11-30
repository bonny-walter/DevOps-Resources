### Example 1: Retrieve AWS AMI Details

# Fetch the latest Amazon Linux 2 AMI in a specific region
    data "aws_ami" "amazon_linux" {
    most_recent = true

    filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }

    filter {
        name   = "owner-id"
        values = ["137112412989"] # Amazon's owner ID
    }
    }

Usage:

    resource "aws_instance" "example" {
    ami           = data.aws_ami.amazon_linux.id
    instance_type = "t2.micro"
    }

### Example 2: Fetch VPC Information

# Fetch a default VPC
    data "aws_vpc" "default" {
    default = true
    }

Usage:

    resource "aws_subnet" "example" {
    vpc_id            = data.aws_vpc.default.id
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    }

### Example 3: Retrieve S3 Bucket Information

# Fetch details of an existing S3 bucket
    data "aws_s3_bucket" "example" {
    bucket = "my-existing-bucket-name"
    }

Usage:

    output "bucket_arn" {
    value = data.aws_s3_bucket.example.arn
    }

### Example 4: Fetch Availability Zones

# Retrieve a list of available availability zones in the current region
    data "aws_availability_zones" "available" {
    state = "available"
    }

Usage:

    resource "aws_subnet" "example" {
    count           = 3
    vpc_id          = "vpc-12345678"
    cidr_block      = cidrsubnet("10.0.0.0/16", 8, count.index)
    availability_zone = data.aws_availability_zones.available.names[count.index]
    }

### Example 5: Fetch IAM Role Information

# Fetch an existing IAM role
    data "aws_iam_role" "example" {
    name = "my-existing-role"
    }

Usage:

    resource "aws_instance_profile" "example" {
    name  = "example-instance-profile"
    role  = data.aws_iam_role.example.name
    }

### Example 6: Get Security Group Details

# Fetch an existing security group
    data "aws_security_group" "example" {
    name = "my-security-group"
    }

Usage:

    resource "aws_instance" "example" {
    ami           = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
    security_groups = [data.aws_security_group.example.name]
    }

### Example 7: Retrieve Elastic IP Details

# Fetch details of an existing Elastic IP
    data "aws_eip" "example" {
    public_ip = "203.0.113.25"
    }

Usage:

    output "eip_allocation_id" {
    value = data.aws_eip.example.allocation_id
    }

### Example 8: Fetch EC2 Key Pair

# Fetch details of an existing key pair
    data "aws_key_pair" "example" {
    key_name = "my-existing-key-pair"
    }

Usage:

    resource "aws_instance" "example" {
    ami           = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
    key_name      = data.aws_key_pair.example.key_name
    }
