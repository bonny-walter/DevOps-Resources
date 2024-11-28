provider "aws" {
  region = "us-east-2"
}

# Create an S3 bucket for Lambda code deployment
resource "aws_s3_bucket" "lambda_bucket" {
  bucket        = "my-lambda-bucket-unique-name"
  
  force_destroy = true

  tags = {
    Name = "lambda-bucket"
  }
}

# Upload Lambda code to the S3 bucket
resource "aws_s3_object" "lambda_zip" {
  bucket = aws_s3_bucket.lambda_bucket.id
  key    = "lambda-function.zip"
  source = "path/to/lambda-function.zip" # Path to your local zip file
}

# Create an IAM role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "Lambda Execution Role"
  }
}

# Attach policies to the IAM role
resource "aws_iam_policy_attachment" "lambda_execution_attach" {
  name       = "lambda_execution_attach"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole" # Basic Lambda permissions
}

# Create the Lambda function
resource "aws_lambda_function" "example_lambda" {
  function_name = "example-lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"             # Change according to your function
  runtime       = "nodejs18.x"                # Change runtime as needed
  s3_bucket     = aws_s3_bucket.lambda_bucket.id
  s3_key        = aws_s3_object.lambda_zip.key
  timeout       = 10                          # Function timeout in seconds
  memory_size   = 128                         # Memory allocated to the function (MB)

  environment {
    variables = {
      ENV = "dev"
    }
  }

  tags = {
    Name        = "Example Lambda"
    Environment = "Dev"
  }
}

# Optional: Create a CloudWatch log group for Lambda logs
resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${aws_lambda_function.example_lambda.function_name}"
  retention_in_days = 7

  tags = {
    Name = "Lambda Log Group"
  }
}

# Output Lambda function details
output "lambda_function_name" {
  value = aws_lambda_function.example_lambda.function_name
}

output "lambda_function_arn" {
  value = aws_lambda_function.example_lambda.arn
}

output "lambda_s3_bucket" {
  value = aws_s3_bucket.lambda_bucket.id
}
