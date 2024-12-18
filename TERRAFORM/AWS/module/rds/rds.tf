
#Call VPC Module First to get the Subnet IDs
# module "project1-vpc" {
#     source      = "../vpc"

#     ENVIRONMENT = var.ENVIRONMENT
#     AWS_REGION  = var.AWS_REGION
# }

#Define Subnet Group for RDS Service
resource "aws_db_subnet_group" "project1-rds-subnet-group" {

    name          = "${var.ENVIRONMENT}-project1-db-snet"
    description   = "Allowed subnets for DB cluster instances"
    subnet_ids    = [
      "${var.vpc_private_subnet1}",
      "${var.vpc_private_subnet2}",
    ]
    tags = {
        Name         = "${var.ENVIRONMENT}_project1_db_subnet"
    }
}

#Define Security Groups for RDS Instances
resource "aws_security_group" "project1-rds-sg" {

  name = "${var.ENVIRONMENT}-project1-rds-sg"
  description = "Created by project1"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["${var.RDS_CIDR}"]

  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
    Name = "${var.ENVIRONMENT}-project1-rds-sg"
   }
}

resource "aws_db_instance" "project1-rds" {
  identifier = "${var.ENVIRONMENT}-project1-rds"
  allocated_storage = var.PROJECT1_RDS_ALLOCATED_STORAGE
  storage_type = "gp2"
  engine = var.PROJECT1_RDS_ENGINE
  engine_version = var.PROJECT1_RDS_ENGINE_VERSION
  instance_class = var.DB_INSTANCE_CLASS
  backup_retention_period = var.BACKUP_RETENTION_PERIOD
  publicly_accessible = var.PUBLICLY_ACCESSIBLE
  username = var.PROJECT1_RDS_USERNAME
  password = var.PROJECT1_RDS_PASSWORD
  vpc_security_group_ids = [aws_security_group.project1-rds-sg.id]
  db_subnet_group_name = aws_db_subnet_group.project1-rds-subnet-group.name
  multi_az = "false"
}

output "rds_prod_endpoint" {
  value = aws_db_instance.project1-rds.endpoint
}