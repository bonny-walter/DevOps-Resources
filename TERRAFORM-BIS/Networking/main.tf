provider "aws" {
  region = "us-east-2"
}

# Data source for availability zones
data "aws_availability_zones" "available" {}

# Create a VPC
resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}

# Create public subnets
resource "aws_subnet" "public_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.main_vpc.cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

# Create private subnets
resource "aws_subnet" "private_subnet" {
  count             = 2
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.main_vpc.cidr_block, 8, count.index + 2)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "main-igw"
  }
}

# Create Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  count = 2
  tags = {
    Name = "nat-eip-${count.index + 1}"
  }
}

# Create NAT Gateways in Public Subnets
resource "aws_nat_gateway" "nat_gw" {
  count         = 2
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id
  tags = {
    Name = "nat-gw-${count.index + 1}"
  }
}

# Create Route Tables for Public Subnets
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "public-rt"
  }
}

# Route to Internet Gateway for Public Subnets
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate Route Table with Public Subnets
resource "aws_route_table_association" "public_rt_assoc" {
  count          = 2
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

# Create Route Tables for Private Subnets
resource "aws_route_table" "private_rt" {
  count  = 2
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "private-rt-${count.index + 1}"
  }
}

# Route to NAT Gateway for Private Subnets
resource "aws_route" "private_route" {
  count                  = 2
  route_table_id         = aws_route_table.private_rt[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw[count.index].id
}

# Associate Route Table with Private Subnets
resource "aws_route_table_association" "private_rt_assoc" {
  count          = 2
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt[count.index].id
}

# Create NACL for Public Subnets
resource "aws_network_acl" "public_nacl" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "public-nacl"
  }
}

# Allow inbound HTTP/HTTPS traffic in Public NACL
resource "aws_network_acl_rule" "public_inbound" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 100
  egress         = false
  protocol       = "6" # TCP
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 443
  rule_action    = "allow"
}

# Allow outbound traffic from Public NACL
resource "aws_network_acl_rule" "public_outbound" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 200
  egress         = true
  protocol       = "-1" # All protocols
  cidr_block     = "0.0.0.0/0"
  rule_action    = "allow"
}

# Associate Public NACL with Public Subnets
resource "aws_network_acl_association" "public_assoc" {
  count          = 2
  subnet_id      = aws_subnet.public_subnet[count.index].id
  network_acl_id = aws_network_acl.public_nacl.id
}

# Create NACL for Private Subnets
resource "aws_network_acl" "private_nacl" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "private-nacl"
  }
}

# Allow inbound traffic from VPC CIDR in Private NACL
resource "aws_network_acl_rule" "private_inbound" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 100
  egress         = false
  protocol       = "-1" # All protocols
  cidr_block     = aws_vpc.main_vpc.cidr_block
  rule_action    = "allow"
}

# Allow outbound traffic from Private NACL
resource "aws_network_acl_rule" "private_outbound" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 200
  egress         = true
  protocol       = "-1" # All protocols
  cidr_block     = "0.0.0.0/0"
  rule_action    = "allow"
}

# Associate Private NACL with Private Subnets
resource "aws_network_acl_association" "private_assoc" {
  count          = 2
  subnet_id      = aws_subnet.private_subnet[count.index].id
  network_acl_id = aws_network_acl.private_nacl.id
}

# Outputs
output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "public_subnets" {
  value = aws_subnet.public_subnet[*].id
}

output "private_subnets" {
  value = aws_subnet.private_subnet[*].id
}

output "nat_gateways" {
  value = aws_nat_gateway.nat_gw[*].id
}
