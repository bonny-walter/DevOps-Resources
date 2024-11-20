
resource "aws_eks_cluster" "eks" {
  name     = format("%s-%s-%s", var.tags["id"], var.tags["environment"], var.tags["project"])
  role_arn = aws_iam_role.eks_cluster.arn
  version  = var.eks_version

  vpc_config {
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    subnet_ids = [
      data.aws_subnet.public-01.id,
      data.aws_subnet.public-02.id,
      data.aws_subnet.public-03.id
    ]
  }
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy
  ]
}

