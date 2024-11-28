### Explanation of Key Resources

    Security Group: Allows access to the RDS instance on port 3306 (MySQL). Restrict cidr_blocks for better security.


    Subnet Group: Ensures the RDS instance is deployed in specified subnets within a VPC.

    RDS Instance:

        engine: MySQL database.
        allocated_storage: Starts with 20GB and can scale up to 100GB.
        publicly_accessible: Set to false to restrict access to within the VPC.
        skip_final_snapshot: Avoids creating a final snapshot when deleting the instance (not recommended for production).
        
    Outputs: Provides the RDS endpoint and instance identifier for easy reference.