Certainly! Below is a basic example of how to implement a Jenkins master and agent setup on AWS using Terraform. This example will use an Amazon EKS cluster for Kubernetes deployment.

### Prerequisites
1. **Terraform installed** on your local machine.
2. **AWS CLI configured** with appropriate permissions.
3. **kubectl installed** for managing Kubernetes.

### Terraform Configuration

#### 1. **Provider Configuration**
Create a file named `main.tf` and add the following code to configure the AWS provider:

```hcl
provider "aws" {
  region = "us-west-2"  # Change to your preferred region
}
```

#### 2. **Create EKS Cluster**
Add the following code to your `main.tf` file to create an EKS cluster:

```hcl
resource "aws_eks_cluster" "jenkins_cluster" {
  name     = "jenkins-cluster"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = aws_subnet.eks_subnet.*.id
  }

  depends_on = [aws_iam_role_policy_attachment.eks_policy]
}

resource "aws_iam_role" "eks_role" {
  name = "eks_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Effect    = "Allow"
      Sid       = ""
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_role.name
}
```

#### 3. **Create VPC and Subnets**
Add the following to your `main.tf` to create a VPC and subnets:

```hcl
resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "eks_subnet" {
  count             = 2
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
}

data "aws_availability_zones" "available" {}
```

#### 4. **Node Group for Jenkins Agents**
Add the following to create a node group for Jenkins agents:

```hcl
resource "aws_eks_node_group" "jenkins_nodes" {
  cluster_name    = aws_eks_cluster.jenkins_cluster.name
  node_group_name = "jenkins-nodes"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.eks_subnet.*.id

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
}

resource "aws_iam_role" "eks_node_role" {
  name = "eks_node_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Effect    = "Allow"
      Sid       = ""
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_role.name
}
```

#### 5. **Deploy Jenkins using Kubernetes**
After your EKS cluster is set up, you can deploy Jenkins using a Kubernetes manifest. Create a file named `jenkins-deployment.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: jenkins
spec:
  replicas: 1
  selector:
    matchLabels:
      app: jenkins
  template:
    metadata:
      labels:
        app: jenkins
    spec:
      containers:
      - name: jenkins
        image: jenkins/jenkins:lts
        ports:
        - containerPort: 8080
        volumeMounts:
        - name: jenkins-home
          mountPath: /var/jenkins_home
      volumes:
      - name: jenkins-home
        emptyDir: {}
---
apiVersion: v1
kind: Service
metadata:
  name: jenkins
spec:
  type: LoadBalancer
  ports:
  - port: 8080
    targetPort: 8080
  selector:
    app: jenkins
```

#### 6. **Apply Terraform Configuration**
Run the following commands in your terminal:

```bash
terraform init
terraform apply
```

After applying the Terraform configuration, wait for the EKS cluster and node group to be created. 

#### 7. **Deploy Jenkins**
Once the EKS cluster is ready, use `kubectl` to deploy Jenkins:

```bash
kubectl apply -f jenkins-deployment.yaml
```

### Accessing Jenkins
Once Jenkins is running, you can get the external IP of the service using:

```bash
kubectl get svc jenkins
```

You can then access Jenkins using that IP address on port 8080.

### Final Notes
- Ensure you clean up resources after testing by running `terraform destroy`.
- This is a basic setup. For production, consider adding persistent storage for Jenkins, configuring security groups, and setting up IAM roles with the least privilege. 

Feel free to ask if you have any questions or need further customization!




Certainly! Below is an example of how to implement a Jenkins server setup using Amazon ECS with Terraform. This example will create an ECS cluster, define a task for Jenkins, and set up a service to run it.

### Prerequisites
1. **Terraform installed** on your local machine.
2. **AWS CLI configured** with appropriate permissions.

### Terraform Configuration

#### 1. **Provider Configuration**
Create a file named `main.tf` and add the following code to configure the AWS provider:

```hcl
provider "aws" {
  region = "us-west-2"  # Change to your preferred region
}
```

#### 2. **Create VPC and Subnets**
Add the following code to `main.tf` to create a VPC and subnets:

```hcl
resource "aws_vpc" "ecs_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "ecs_subnet" {
  count             = 2
  vpc_id            = aws_vpc.ecs_vpc.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
}

data "aws_availability_zones" "available" {}
```

#### 3. **Create Security Group**
Add a security group for your ECS tasks:

```hcl
resource "aws_security_group" "ecs_sg" {
  vpc_id = aws_vpc.ecs_vpc.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust to restrict access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

#### 4. **Create ECS Cluster**
Add the following to create an ECS cluster:

```hcl
resource "aws_ecs_cluster" "jenkins_cluster" {
  name = "jenkins-cluster"
}
```

#### 5. **Create Task Definition**
Define a task for Jenkins:

```hcl
resource "aws_ecs_task_definition" "jenkins_task" {
  family                   = "jenkins"
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = "256"
  memory                  = "512"

  container_definitions = jsonencode([{
    name      = "jenkins"
    image     = "jenkins/jenkins:lts"
    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
      protocol      = "tcp"
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = aws_cloudwatch_log_group.jenkins_logs.name
        "awslogs-region"        = "us-west-2"  # Change to your region
        "awslogs-stream-prefix" = "jenkins"
      }
    }
  }])
}
```

#### 6. **Create CloudWatch Log Group**
Add a log group for Jenkins logs:

```hcl
resource "aws_cloudwatch_log_group" "jenkins_logs" {
  name = "jenkins-logs"
}
```

#### 7. **Create ECS Service**
Create a service to run the Jenkins task:

```hcl
resource "aws_ecs_service" "jenkins_service" {
  name            = "jenkins-service"
  cluster         = aws_ecs_cluster.jenkins_cluster.id
  task_definition = aws_ecs_task_definition.jenkins_task.id
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = aws_subnet.ecs_subnet[*].id
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }
}
```

### 8. **Output the Jenkins URL**
Add an output to get the service details:

```hcl
output "jenkins_service_url" {
  value = "http://${aws_ecs_service.jenkins_service.id}.us-west-2.elasticbeanstalk.com:8080"
}
```

### 9. **Apply Terraform Configuration**
Run the following commands in your terminal:

```bash
terraform init
terraform apply
```

### Accessing Jenkins
Once the infrastructure is set up, you can find the public IP of the ECS service using:

```bash
aws ecs describe-services --cluster jenkins-cluster --servicvapes jenkins-service
```

You can then access Jenkins using the public IP on port 8080.

### Final Notes
- Ensure to clean up resources after testing by running `terraform destroy`.
- This is a basic setup. For production, consider adding persivstent storage for Jenkins, configuring IAM roles, and implementing security best practices.

Feel free to ask if you have any qu
