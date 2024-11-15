                                  AWS RDS Service

### AWS offers:
    MySQL 
    PostgreSQL
    MariaDB
    Oracle 
    SQL Server 
    Amazon Aurora database services.

### Amazon Aurora is a MySQL and PostgreSQL-compatible and fully managed by Amazon and it is not included in free tier. 
### If you launch Aurora cluster, it will costs to you for what you use and how much time you use.

### You can provision RDS in the AWS cloud using terraform.
### To create a database instance, we have a resource type "aws_db_instance" in terraform.
### To create an aurora database cluster and cluster instances, we have resource types "aws_rds_cluster" and "aws_rds_cluster_instance" in terraform.
### By adding the required arguments as per the requirement, we can provision RDS instance in the AWS cloud.

    RDS Instance

### The "aws_db_instance" resource type provides an RDS instance resource. 
### A DB instance is an isolated database environment in the cloud.

resource "aws_db_instance" "mydatabase" {
  allocated_storage = 10
  storage_type      = "gp2"
  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t2.micro"
  db_name           = "mydb"
  username          = "root"
  password          = "Pa$#W0rD"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}


### Following are the mandatory arguments:

        allocated_storage
        engine
        instance_class
        username
        password


### You can create MySQL, MariaDB, PostgreSQL, Oracle, SQL Server DB instances by mentioning engine type and engine_version.
### To enable multi-AZ, use multi_az = true.

### You can also add maintenance, backup windows and retention period using following attributes
        backup_window
        backup_retention_period
        maintenance_window

There are other attributes to enable encryption, enable delete protection, to assign security groups and subnets and version upgrade etc.

       Aurora Cluster:

### You can provision RDS Aurora Cluster with resource type "aws_rds_cluster" in terraform configuration. Also, to create cluster instances, it has another resource type "aws_rds_cluster_instance".

### Following are the mandatory arguments to create a cluster
        master_password
        master_username

### Following are the mandatory arguments to create a cluster instances
        instance_class
        db_subnet_group_name (if publicly_accessible = false)
        cluster_identifier

### Aurora cluster engine supports aurora, aurora-mysql, aurora-postgresql and default value is aurora. 
### The engine_mode supported values are global, parallel query, provisioned, serverless and the default value is provisioned.

resource "aws_rds_cluster" "aurora-mysql" {
  cluster_identifier = "aurora-mysql-cluster"
  engine             = "aurora-mysql"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  database_name      = "mydb"
  master_username    = "root"
  master_password    = "Ro0t19Passwd"
  backup_retention_period = 2
  preferred_backup_window = "02:00-03:00"
  skip_final_snapshot     = true
}

### Aurora with PostgreSQL engine

resource "aws_rds_cluster" "aurora-postgresql" {
  cluster_identifier = "aurora-postgresql-cluster"
  engine             = "aurora-postgresql"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  database_name      = "mydb"
  master_username    = "root"
  master_password    = "Ro0t19Passwd"
  backup_retention_period = 2
  preferred_backup_window = "01:00-02:00"
  skip_final_snapshot     = true
}


### Aurora Cluster Instances:

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 3
  identifier         = "aurora-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.aurora-mysql.id
  instance_class     = "db.r4.large"
  engine             = aws_rds_cluster.aurora-mysql.engine
}


### Add other arguments as per the requirements. 
### Following are the arguments commonly used :

Cluster:
deletion_protection
final_snapshot_identifier
availability_zones
backup_retention_period
preferred_backup_window
preferred_maintenance_window
vpc_security_group_ids
storage_encrypted
db_subnet_group_name
db_cluster_parameter_group_name
engine
engine_mode
engine_version
tags
enabled_cloudwatch_logs_exports
scaling_configuration ( if engine_mode = "serverless" )
Cluster Instances:
identifier
cluster_identifier
engine
engine_version
instance_class
publicly_accessible
db_subnet_group_name
db_parameter_group_name
monitoring_interval


