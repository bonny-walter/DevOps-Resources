### Explanation of Resources

    VPC: Main VPC with a /16 CIDR.

    Public Subnets: Two subnets for internet-facing resources.

    Private Subnets: Two subnets for private resources.

    Internet Gateway: For outbound internet access from public subnets.

    NAT Gateways: One per public subnet for private subnet internet access.

    Route Tables: Separate route tables for public and private subnets.
    
    NACLs:
        Public NACL allows inbound HTTP/HTTPS traffic and outbound traffic.
        Private NACL restricts traffic to internal VPC communication and outbound traffic.