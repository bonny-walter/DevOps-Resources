### Terraform provisioners are used to execute scripts or commands on resources after they have been created. 
### They are useful for configuring resources in place, such as installing software or setting up environment configurations
### There are two main types of provisioners in Terraform:

    1- remote-exec: Executes commands on a remote machine.
    2- local-exec: Executes commands on the machine running Terraform.


### Example 1: remote-exec Provisioner to Install Apache Web Server on EC2

# EC2 Instance
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"  # Example Amazon Linux AMI
  instance_type = "t2.micro"

  # Using remote-exec provisioner to install Apache
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "sudo service httpd start",
      "sudo chkconfig httpd on"
    ]

    # Connection details for SSH access
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }

  tags = {
    Name = "WebServer"
  }
}

    The remote-exec provisioner will run on the instance after it is created.
    The SSH connection is made using the public IP of the instance and an SSH key.


### Example 2: local-exec Provisioner to Run a Script Locally

# Using local-exec provisioner to run a local shell script after creating an S3 bucket
resource "aws_s3_bucket" "example" {
  bucket = "my-terraform-bucket"
  acl    = "private"

  provisioner "local-exec" {
    command = "echo 'S3 Bucket ${self.bucket} created' >> /tmp/bucket_creation_log.txt"
  }
}

    The local-exec provisioner runs a command on the local machine (where Terraform is running).
    It appends the creation log to a file /tmp/bucket_creation_log.txt after the bucket is created.


### Example 3: remote-exec with Script File to Configure EC2

Instead of inline commands, you can use a script file to execute commands remotely on the instance:

# EC2 Instance with a remote-exec provisioner using a script file
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  provisioner "remote-exec" {
    script = "setup-webserver.sh"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }

  tags = {
    Name = "WebServer"
  }
}

In this example, the script setup-webserver.sh contains the necessary commands to configure the instance, such as installing Apache, configuring firewall settings, etc.


### Example 4: local-exec to Run AWS CLI Commands After Resource Creation

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "aws s3 cp /tmp/my-file.txt s3://my-bucket/"
  }
}

    This example uploads a file from your local machine to an S3 bucket after the EC2 instance is created.
    The aws CLI tool must be installed and configured on the local machine where Terraform is running.



### Example 5: remote-exec with Multiple Commands and Timeout

You can also specify a timeout for the remote execution:

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y nginx",
      "sudo systemctl start nginx"
    ]

    timeout = "10m"  # Timeout for remote-exec provisioner

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }

  tags = {
    Name = "WebServer"
  }
}

    This provisioner will run the specified commands on the EC2 instance and will time out after 10 minutes if not completed.
    You can use timeout to control how long Terraform waits for the provisioner to complete before moving on.