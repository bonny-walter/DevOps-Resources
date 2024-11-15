
### IAM Role and Policy:

### Define an IAM role named "elastic-beanstalk-service-role" with a policy that allows Elastic Beanstalk to assume the role.

resource "aws_iam_role" "elastic_beanstalk_service_role" {
  name = "elastic-beanstalk-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "elasticbeanstalk.amazonaws.com"
        }
      }
    ]
  })
}


###  Define an IAM instance profile named elastic-beanstalk-instance-role.

resource "aws_iam_instance_profile" "beanstalk_profile" {
  name = "beanstalk_profile"
  role = aws_iam_role.elastic_beanstalk_service_role.name
}

### Define an IAM policy named "elastic-beanstalk-policy" that specifies the permissions needed for Elastic Beanstalk.
   (You can adjust the permissions in this policy as per your requirements.)

resource "aws_iam_policy" "elastic_beanstalk_policy" {
  name = "elastic-beanstalk-policy"

  description = "Permissions for Elastic Beanstalk to create and manage AWS resources."

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "ec2:*",
        Effect   = "Allow",
        Resource = "*"
      }
      # Add more permissions as needed for your specific use case
    ]
  })
}

### Define policy attachment to attach the policy to the IAM role.

resource "aws_iam_role_policy_attachment" "attach_elastic_beanstalk_policy" {
  policy_arn = aws_iam_policy.elastic_beanstalk_policy.arn
  role       = aws_iam_role.elastic_beanstalk_service_role.name
}


              Elastic Beanstalk Resources:
### Define your Elastic Beanstalk application with the iam role defined above.

resource "aws_elastic_beanstalk_application" "myapp" {
  name        = "my-test-app"
  description = "My Elastic Beanstalk application"

  appversion_lifecycle {
    service_role          = aws_iam_role.elastic_beanstalk_service_role.arn
    max_count             = 128
    delete_source_from_s3 = true
  }
}


### Define your Elastic Beanstalk environment with required setting blocks.

resource "aws_elastic_beanstalk_environment" "myapp_dev" {
  name                = "myapp-dev"
  application         = aws_elastic_beanstalk_application.myapp.name
  solution_stack_name = "64bit Amazon Linux 2023 v4.0.4 running Python 3.11"
  # Change this to your desired stack
  cname_prefix        = "srinisbook-dev"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.beanstalk_profile.name
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
    # Change this to your desired instance type
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "SingleInstance"
    # Change this to "LoadBalanced" for a load-balanced environment
  }
}

### You can customize the solution stack name, cname prefix, InstanceType, and also you can more setting blocks as per your requirement.

