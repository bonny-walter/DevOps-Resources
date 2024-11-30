provider "aws" {
  region = "us-east-2"
}

module "ec2_instance" {
        source        = "./custom-modules/EC2-Instance"
        ami           = "ami-0ea3c35c5c3284d82"  # Example AMI ID
        instance_type = "t2.micro"
        instance_name = "MyEC2Instance"
}
