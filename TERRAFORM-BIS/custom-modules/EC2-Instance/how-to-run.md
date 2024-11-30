### In your root configuration, create a main.tf file to use the ec2-instance module:

# main.tf
        module "ec2_instance" {
        source        = "./custom-modules/ec2-instance"
        ami           = "ami-0c55b159cbfafe1f0"  # Example AMI ID
        instance_type = "t2.micro"
        instance_name = "MyEC2Instance"
        }
# Apply the Configuration.

# Initialize and apply the configuration:

    terraform init
    terraform apply

### This will create an EC2 instance using the configuration from the ec2-instance module.