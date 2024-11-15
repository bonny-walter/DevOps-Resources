


                                         AWS Network Resources


### To create AWS network resources such as a VPC, subnet, network security group, internet gateway, and route table using 
### Terraform, define the resources as below:
### VPC:

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "MY-VPC"
  }
}

### Replace cidr_block value with your desired VPC CIDR block.
### To create a VPC, cidr_block is a mandatory argument. Following are the other arguments.


instance_tenancy
enable_dns_support
enable_dns_hostnames
assign_generated_ipv6_cidr_block
enable_classiclink
tags


resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"
  tags {
    Name = "MY-VPC"
  }
}


### Subnet:

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.0.0/24"
  tags = {
    Name = "subnet-1"
  }
}

### To create a Subnet, cidr_block and vpc_id arguments are mandatory. 
### Following are the other arguments.

availability_zone
availability_zone_id
ipv6_cidr_block
map_public_ip_on_launch
assign_ipv6_address_on_creation
tags
data "aws_availability_zones" "azs" {}


variable "subnet_cidr" {
  type    = "list"
  default = ["10.0.1.0/24", "10.0.2.0/24","10.0.3.0/24"]
}


resource "aws_subnet" "my_vpc_subnets" {
  count      = length(var.subnet_cidr)
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "${element(var.subnet_cidr, count.index)}"

  map_public_ip_on_launch = "true"
  availability_zone = "${element(data.aws_availability_zones.azs.names, count.index)}"
  tags {
    Name = "my_vpc_subnet-${count.index+1}"
  }
}

### Route table:

### To create a route table, vpc_id attribute is mandatory.

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id
}

### Following arguments are supported:

route
tags
propagating_vgws

resource "aws_route_table" "my_vpc_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.my_vpc_gw.id}"
  }

  tags {
    Name = "MY VPC Route Table"
  }
}


### The route block can be added multiple times as per your requirement.
### Associate route table to a subnet:

resource "aws_route_table_association" "rt-association" {
  count     = length(var.subnet_cidr)
  subnet_id = "${element(aws_subnet.my_vpc_subnets.*.id, count.index)}"
  route_table_id = aws_route_table.my_vpc_route_table.id
}


### Security Groups:
### To create security group from_port, protocol and to_port are mandatory arguments in ingress and egress.

resource "aws_security_group" "my_security_group" {
  name = "my_security_group"
  vpc_id = aws_vpc.my_vpc.id
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "TCP"
    cidr_blocks = ["${var.vpc_cidr}"]
  }
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

### Protocol value "-1" is equivalent to "all". Port value 0 means All ports.

### Internet Gateway:
### Following arguments are supported:

vpc_id (mandatory)
tags


resource "aws_internet_gateway" "my_vpc_gw" {
  vpc_id = aws_vpc.my_vpc.id
  tags {
    Name = "My VPC IGW"
  }
}



