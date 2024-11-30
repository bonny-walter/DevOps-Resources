create a main.tf file in root configuration with the below configuration to deploy the entire network
# main.tf
provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source      = "./custom-modules/vpc"
  cidr_block  = "10.0.0.0/16"
}

module "subnets" {
  source               = "./custom-modules/subnets"
  vpc_id               = module.vpc.vpc_id
  public_subnet_cidr   = "10.0.1.0/24"
  private_subnet_cidr  = "10.0.2.0/24"
  az                   = "us-east-2a"
}

module "internet_gateway" {
  source   = "./custom-modules/internet-gateway"
  vpc_id   = module.vpc.vpc_id
}

module "routes" {
  source               = "./custom-modules/routes"
  vpc_id               = module.vpc.vpc_id
  public_subnet_id     = module.subnets.public_subnet_id
  internet_gateway_id  = module.internet_gateway.internet_gateway_id
}

module "nat_gateway" {
  source             = "./custom-modules/nat-gateway"
  public_subnet_id   = module.subnets.public_subnet_id
}

module "security_group" {
  source        = "./custom-modules/security-group"
  vpc_id        = module.vpc.vpc_id
  name          = "my-security-group"
  description   = "Allow HTTP and SSH"
  ssh_cidr_blocks = ["0.0.0.0/0"]
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.subnets.public_subnet_id
}

output "private_subnet_id" {
  value = module.subnets.private_subnet_id
}
