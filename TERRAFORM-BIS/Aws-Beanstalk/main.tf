provider "aws" {
  region = "us-east-2"
}

# Create an Elastic Beanstalk Application
resource "aws_elastic_beanstalk_application" "example" {
  name        = "example-eb-app"
  description = "Example Elastic Beanstalk Application"

  tags = {
    Name = "example-eb-app"
  }
}

# Create an S3 bucket for application versions
resource "aws_s3_bucket" "beanstalk_bucket" {
  bucket        = "example-eb-app-bucket-unique-name"
  

  tags = {
    Name = "Beanstalk Bucket"
  }
}

# Upload application version to S3
resource "aws_s3_object" "app_version" {
  bucket = aws_s3_bucket.beanstalk_bucket.id
  key    = "app.zip"  # The key under which the file is stored in S3
  source = "path/to/your/app.zip"  # Path to your application zip file
}

# Define Elastic Beanstalk Application Version
resource "aws_elastic_beanstalk_application_version" "example_version" {
  name = "example-eb-app-version-label"  
  application = "aws_elastic_beanstalk_application.example.name" 
  
  bucket = aws_s3_bucket.beanstalk_bucket.id
  key    = aws_s3_object.beanstalk_bucket.id
}

# Create an Elastic Beanstalk Environment
resource "aws_elastic_beanstalk_environment" "example_env" {
  name                = "example-eb-env"
  application         = aws_elastic_beanstalk_application.example.name
  solution_stack_name = "64bit Amazon Linux 2 v3.5.2 running Node.js 18"  # Change based on your application's runtime

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t3.micro"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "LoadBalanced"
  }

  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "Port"
    value     = "8080"
  }

  version_label = aws_elastic_beanstalk_application_version.example_version.version_label

  tags = {
    Name = "example-eb-env"
  }
}

# Output Elastic Beanstalk Environment URL
output "elastic_beanstalk_environment_url" {
  value = aws_elastic_beanstalk_environment.example_env.endpoint_url
}
