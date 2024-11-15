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



### Kubectl is a command line interface for running commands against Kubernetes clusters and it uses kubeconfig to connect to your ### cluster.
### To create or update a kubeconfig file for your cluster, run the following command:

""" aws eks update-kubeconfig --region us-east-1 --name my-eks-cluster-001 """

Test your configuration:
        $ kubectl get nodes







