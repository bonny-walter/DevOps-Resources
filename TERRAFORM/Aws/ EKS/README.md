                                    AWS Kubernetes Service

### Amazon Elastic Container Service for Kubernetes (Amazon EKS) makes it easy to deploy, manage, and scale containerized applications using Kubernetes on AWS.

### Amazon EKS runs the Kubernetes management infrastructure across multiple AWS Availability Zones, automatically detects and replaces unhealthy control plane nodes, and provides on-demand upgrades and patching.

You simply provision worker nodes and connect them to the provided Amazon EKS endpoint.

### The architecture includes the following resources:
    1- EKS Cluster: AWS managed Kubernetes cluster of master servers
    2- AutoScaling Group
    3- Associated VPC, Internet Gateway, Security Groups, and Subnets
    4- Associated IAM Roles and Policies

### Define VPC:
### """It is recommended to launch your EKS worker nodes in a separate VPC.
       It enables you to launch worker nodes into a virtual network that you've defined."""

### The VPC includes public subnet, gateway, routes, route tables, and security groups.

resource "aws_vpc" "eks-vpc" {
  cidr_block = "10.100.0.0/16"
  tags       = {
    Name = "EKS-VPC"
  }
}


data "aws_availability_zones" "available" {}


resource "aws_subnet" "eks-node-subnet" {
  count             = 3
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = "10.100.${count.index}.0/24"
  vpc_id            = aws_vpc.eks-vpc.id
  tags = {
    Name = "eks-subnet-${count.index+1}"
  }
}


resource "aws_internet_gateway" "eks-gw" {
  vpc_id = aws_vpc.eks-vpc.id
  tags   = {
    Name = "eks-igw"
  }
}


resource "aws_route_table" "eks-rt" {
  vpc_id = aws_vpc.eks-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.eks-gw.id}"
  }
}


resource "aws_route_table_association" "eks-rt-association" {
  count          = 3
  subnet_id      = aws_subnet.eks-node-subnet.*.id[count.index]
  route_table_id = "${aws_route_table.eks-rt.id}"
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

        1- AmazonEKSServicePolicy
        2- AmazonEKSClusterPolicy

resource "aws_iam_role" "eks-cluster-role" {
  name = "eks-cluster-role"
  assume_role_policy = << POLICY
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
  role       = aws_iam_role.cluster-role.name
}


resource "aws_iam_role_policy_attachment" "eks-policy-service-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.cluster-role.name
}


### For Worker nodes, you must create an IAM role with the following IAM policies:
        1- AmazonEKSWorkerNodePolicy
        2- AmazonEKS_CNI_Policy
        3- AmazonEC2ContainerRegistryReadOnly

resource "aws_iam_role" "eks-worker-role" {
  name = "eks-worker-role"

  assume_role_policy = << POLICY
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
  name = "my-eks-cluster-001"
  role_arn = aws_iam_role.cluster-role.arn

  vpc_config {
    security_group_ids = [aws_security_group.eks-cluster-sg.id]
    subnet_ids = aws_subnet.eks-node-subnet.*.id
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


### Kubectl is a command line interface for running commands against Kubernetes clusters and it uses kubeconfig to connect to your ### cluster.
### To create or update a kubeconfig file for your cluster, run the following command:

""" aws eks update-kubeconfig --region us-east-1 --name my-eks-cluster-001 """

Test your configuration:
        $ kubectl get nodes
        NAME                           STATUS   ROLES      AGE   VERSION
        ip-10-100-0-98.ec2.internal    Ready    < none >   19m   v1.27.5-eks-43840fb
        ip-10-100-1-86.ec2.internal    Ready    < none >   19m   v1.27.5-eks-43840fb
        ip-10-100-2-149.ec2.internal   Ready    < none >   19m   v1.27.5-eks-43840fb






