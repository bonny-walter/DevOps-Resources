provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "myvm" {
  ami             = "ami-03a6eaae9938c858c"
  instance_type   = "t2.micro"
  key_name = aws_key_pair.deployer.key_name

  user_data = file("userdata.txt")

  tags = {
    Name = "MyVM"
  }
}

output "IPADDRESS" {
  value = "${aws_instance.myvm.public_ip}"
}