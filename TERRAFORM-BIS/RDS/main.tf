provider "aws" {
  region = "us-east-2"
}

# Create a Security Group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow RDS access"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with your specific CIDR for better security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

# Create Subnet Group for RDS
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  description = "RDS Subnet Group"
  subnet_ids  = ["subnet-12345678", "subnet-23456789"] # Replace with your subnet IDs

  tags = {
    Name = "rds-subnet-group"
  }
}

# Create an RDS Instance
resource "aws_db_instance" "rds_instance" {
  allocated_storage    = 20
  max_allocated_storage = 100
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"

  username             = "admin"              # Master username
  password             = "password123!"        # Master password
  parameter_group_name = "default.mysql8.0"    # Default parameter group for MySQL 8.0
  publicly_accessible  = false                 # Set to false for private instances
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  skip_final_snapshot   = true                 # Skip final snapshot on deletion

  tags = {
    Name = "example-rds-instance"
    Environment = "Dev"
  }
}

# Output RDS Instance Endpoint
output "rds_endpoint" {
  value = aws_db_instance.rds_instance.endpoint
}

output "rds_instance_identifier" {
  value = aws_db_instance.rds_instance.id
}
