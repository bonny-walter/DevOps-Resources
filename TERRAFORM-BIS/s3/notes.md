### Features in this Example

    S3 Bucket: Creates a unique S3 bucket with private access.

    Versioning: Ensures all object versions are stored for auditing and recovery.

    Server-Side Encryption: Encrypts objects using AES256 by default.

    Bucket Policy: Allows s3:GetObject permission for everyone (for demonstration purposes; adjust as needed).
    
    Access Logging: Logs S3 bucket access into a separate bucket (my-logging-bucket-unique-name).