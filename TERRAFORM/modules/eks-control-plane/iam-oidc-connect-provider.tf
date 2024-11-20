# Fetches the TLS certificate of the EKS OIDC provider.
# The URL is derived from the identity information of the EKS cluster.
# This data block retrieves the issuer's certificate and fingerprint, 
# which will be used to establish trust between AWS IAM and the OIDC provider.

data "tls_certificate" "example" {
  url = aws_eks_cluster.eks.identity.0.oidc.0.issuer
}

# Creates an IAM OpenID Connect (OIDC) provider for the EKS cluster.
# This allows the cluster to integrate with AWS IAM and use IRSA (IAM Roles for Service Accounts).

resource "aws_iam_openid_connect_provider" "example" {

  # Specifies the trusted client for the OIDC provider. 
  # "sts.amazonaws.com" allows the provider to issue temporary security credentials.

  client_id_list  = ["sts.amazonaws.com"]

  # The thumbprint of the OIDC provider's certificate, retrieved from the tls_certificate data source.
  # This ensures that AWS trusts the OIDC provider.

  thumbprint_list = [data.tls_certificate.example.certificates.0.sha1_fingerprint]

  # The URL of the OIDC issuer for the EKS cluster.

  url             = aws_eks_cluster.eks.identity.0.oidc.0.issuer

  # Adds tags for better manageability and identification of the OIDC provider.
  # Tags are merged from a variable map and include a "Name" tag with a dynamic value.

  tags = merge(var.tags, {
    "Name" = format("%s-%s-%s-openid-connect-provider", var.tags["id"], var.tags["environment"], var.tags["project"])
  })
}

# Outputs the SHA1 fingerprint of the OIDC provider's certificate.
# Useful for debugging or reuse in other modules where the thumbprint is needed.

output "thumbprint_hash" {
  value = data.tls_certificate.example.certificates.0.sha1_fingerprint
}
