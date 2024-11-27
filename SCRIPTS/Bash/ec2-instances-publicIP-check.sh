#!/bin/bash
# Fetch Public IPs of EC2 Instances

REGION="us-east-2"  # Update with your AWS region
echo "Fetching public IPs of running EC2 instances in region: $REGION"

aws ec2 describe-instances --region $REGION \
    --filters Name=instance-state-name,Values=running \
    --query "Reservations[].Instances[].PublicIpAddress" --output text
