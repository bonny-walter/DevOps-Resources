# variables.tf

variable "region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The instance type for the EC2 instance."
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the key pair to use for the EC2 instance."
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "tags" {
  description = "Tags to assign to AWS resources."
  type        = map(string)
  default     = {
    Project = "Terraform-AWS"
    Owner   = "DevOps Team"
  }
}



### ow to Pass Variable Values

    Use a terraform.tfvars file:

region        = "us-east-2"
instance_type = "t3.micro"
key_name      = "my-key-pair"

   Use CLI flags:

    terraform apply -var="region=us-east-2" -var="key_name=my-key-pair"

