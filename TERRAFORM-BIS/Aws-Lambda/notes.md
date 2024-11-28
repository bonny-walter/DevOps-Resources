### Explanation of Key Resources

    S3 Bucket:
        Stores the Lambda package (lambda-function.zip) uploaded from your local machine.
        Use the force_destroy flag to delete the bucket and its contents when destroying the infrastructure.

    IAM Role:
        Grants the Lambda function permission to execute by allowing the AWSLambdaBasicExecutionRole policy.

    Lambda Function:
        Configures the runtime, handler, and environment variables.
        Uses the s3_bucket and s3_key to deploy code from S3.

    CloudWatch Logs:
        Creates a log group to store Lambda logs with a 7-day retention policy.