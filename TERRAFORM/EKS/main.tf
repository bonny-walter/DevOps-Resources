
provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "eks-vpc" {
  cidr_block = "10.100.0.0/16"
  tags = {
    Name = "EKS-VPC"
  }
}


data "aws_availability_zones" "available" {}


resource "aws_subnet" "eks-node-subnet" {
  count             = 3
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = "10.100.${count.index}.0/24"
  vpc_id            = aws_vpc.eks-vpc.id
  map_public_ip_on_launch = "true"
  tags = {
    Name = "eks-subnet-${count.index + 1}"
  }
}


resource "aws_internet_gateway" "eks-gw" {
  vpc_id = aws_vpc.eks-vpc.id
  tags = {
    Name = "eks-igw"
  }
}


resource "aws_route_table" "eks-rt" {
  vpc_id = aws_vpc.eks-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-gw.id
  }
}


resource "aws_route_table_association" "eks-rt-association" {
  count          = 3
  subnet_id      = aws_subnet.eks-node-subnet.*.id[count.index]
  route_table_id = aws_route_table.eks-rt.id
}


### Define EKS Security Groups:

### Security groups act as a firewall for associated master and worker nodes, controlling both inbound and outbound traffic at the ### instance level.

### Master Node Security Group :

resource "aws_security_group" "eks-cluster-sg" {
  name        = "eks-cluster-sg"
  description = "EKS Cluster Security Group"
  vpc_id      = aws_vpc.eks-vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1025
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-cluster-sg"
  }
}

### Define IAM role and policy:
### Amazon EKS makes calls to other AWS services to manage the resources that you use with the service.
### Before you can use the service, you must create an IAM role with the following IAM policies:

#        1- AmazonEKSServicePolicy
#        2- AmazonEKSClusterPolicy

resource "aws_iam_role" "eks-cluster-role" {
  name               = "eks-cluster-role"
  assume_role_policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
 POLICY
}


resource "aws_iam_role_policy_attachment" "eks-policy-cluster-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-role.name
}


resource "aws_iam_role_policy_attachment" "eks-policy-service-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks-cluster-role.name
}


### For Worker nodes, you must create an IAM role with the following IAM policies:
#        1- AmazonEKSWorkerNodePolicy
#        2- AmazonEKS_CNI_Policy
#        3- AmazonEC2ContainerRegistryReadOnly

resource "aws_iam_role" "eks-worker-role" {
  name = "eks-worker-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
  {
    "Effect": "Allow",
    "Principal": {
      "Service": "ec2.amazonaws.com"
    },
    "Action": "sts:AssumeRole"
  }
  ]
}
POLICY
}


resource "aws_iam_role_policy_attachment" "worker-node-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-worker-role.name
}


resource "aws_iam_role_policy_attachment" "worker-node-cni" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-worker-role.name
}


resource "aws_iam_role_policy_attachment" "worker-node-ecr" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-worker-role.name
}


resource "aws_iam_instance_profile" "worker-node-profile" {
  name = "eks-worker-node-profile"
  role = aws_iam_role.eks-worker-role.name
}


### Define EKS Cluster:
### Once the VPC and IAM roles created, we can create EKS cluster with "aws_eks_cluster" resource type.

resource "aws_eks_cluster" "eks-cluster" {
  name     = "my-eks-cluster-001"
  role_arn = aws_iam_role.eks-cluster-role.arn

  vpc_config {
    security_group_ids = [aws_security_group.eks-cluster-sg.id]
    subnet_ids         = aws_subnet.eks-node-subnet.*.id
  }
}

### Define EKS Worker Node groups:
### You can create a node group which will provision the worker nodes.

resource "aws_eks_node_group" "eks-cluster-node-group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "nodegroup-01"
  node_role_arn   = aws_iam_role.eks-worker-role.arn
  subnet_ids      = aws_subnet.eks-node-subnet.*.id

  scaling_config {
    desired_size = 3
    max_size     = 4
    min_size     = 3
  }

  update_config {
    max_unavailable = 1
  }
}

output "eks-cster-name" {
  value = "${aws_eks_cluster.eks-cluster.name}"

}