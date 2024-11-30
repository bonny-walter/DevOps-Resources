1- create a main.tf file in the terraform root directory with  the below configuration 
# main.tf
        module "vpc" {
        source      = "./custom-modules/vpc"
        cidr_block  = "10.0.0.0/16"
        subnet_cidr = "10.0.1.0/24"
        az          = "us-east-2a"
        }
2- initiate and apply changes in infrastructure with: terraform init and terraform apply



Alternatively we can use an official aws vpc module from the terraform registry by creating a main.tf file that contains the below configuration...
                        # main.tf
                        module "vpc" {
                        source              = "terraform-aws-modules/vpc/aws"
                        name                = "my-vpc"
                        cidr                = "10.0.0.0/16"
                        enable_dns_support  = true
                        enable_dns_hostnames = true
                        azs                 = ["us-east-2a", "us-east-2b", "us-east-2c"]
                        private_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
                        public_subnets      = ["10.0.3.0/24", "10.0.4.0/24"]
                        enable_nat_gateway  = true
                        enable_vpn_gateway  = false
                        }
                        