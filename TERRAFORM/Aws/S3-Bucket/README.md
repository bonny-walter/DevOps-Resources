


                                         S3 Service


AWS Simple Storage Service(S3) provides secure, durable and highly scalable object storage.
The resource type "aws_s3_bucket" is used to create S3 buckets.

### Note:

1- Every S3 bucket name must be unique across all existing bucket names in Amazon S3.
2- Bucket names must start with a lowercase letter or number.
3- Bucket names must be at least 3 and no more than 63 characters long.
4- Bucket names must not contain uppercase characters or underscores.


resource "aws_s3_bucket" "mybucket" {
  bucket = "mytests3bucket20231002"
  acl    = "private"

  tags = {
    Name        = "My Bucket"
    Environment = "Dev"
  }
}


### Enable Versioning:
### The versioning argument is used to enable versioning to S3 buckets.

resource "aws_s3_bucket" "mybucket" {
  bucket = "mytests3bucket20231002"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}


### Enable Logging:
### When you enable logging, Amazon S3 delivers access logs for a source bucket to a target bucket that you choose.
### The target bucket must be in the same AWS Region as the source bucket and must not have a default retention period configuration.

resource "aws_s3_bucket" "log_bucket" {
  bucket = "my-log-bucket-20231002"
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "mytests3bucket20231002"
  acl    = "private"

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "logs/"
  }
}


### Enable Server Side Encryption:
### Server-side encryption protects data at rest. Amazon S3 encrypts each object with a unique key.
### Server-side encryption encrypts only the object data, not object metadata.

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "mytests3bucket20231002"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.mykey.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}


### Bucket policy:

    Bucket policy is used to grant other AWS accounts or IAM users access permissions for the bucket and the objects in it.
    The resource type aws_s3_bucket_policy attaches a policy to an S3 bucket resource.

resource "aws_s3_bucket_policy" "mybucketpolicy" {

  bucket = aws_s3_bucket.mybucket.id

  policy = << POLICY
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"AddPerm",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::mytests3bucket20231002/*"]
    }
  ]
}
POLICY
}


### Block Public Access:
        S3 provides block public access settings for buckets and accounts to help you manage public access to Amazon S3 resources.
        The resource type aws_s3_bucket_public_access_block manages S3 bucket-level Public Access Block configuration.

resource "aws_s3_bucket_public_access_block" "mybucket-bpa" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}

### S3 Lifecycle

        Through lifecycle, you can manage your objects cost-effectively. 

      """  A lifecycle configuration is a set of rules that define actions to a group of objects."""

        There are two types of actions:

        1- Transition - Define when objects transition to another storage class
        2- Expiration - Define when objects expire.

        ### Add lifecycle to a bucket using lifecycle_rule argument.


resource "aws_s3_bucket" "mybucket" {
  bucket = "mytests3bucket20231002"
  acl    = "private"

  lifecycle_rule {
    enabled = true
    prefix = "data/"

    transition {
      days          = 30
      storage_class = "STANDARD_IA" # or "ONEZONE_IA"
    }
    transition {
      days          = 60
      storage_class = "GLACIER"
    }
    expiration {
      days = 90
    }
  }
}


### If your bucket enabled versioning, the lifecycle configurations as below:

resource "aws_s3_bucket" "versioning_bucket" {
  bucket = "my-versioning-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true

    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    noncurrent_version_transition {
      days          = 60
      storage_class = "GLACIER"
    }
    noncurrent_version_expiration {
      days = 90
    }
  }
}



