
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

### aurore with mysql engine

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