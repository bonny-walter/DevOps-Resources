#!/bin/bash
# Monitor Nginx Logs

ACCESS_LOG="/var/log/nginx/access.log"
ERROR_LOG="/var/log/nginx/error.log"

echo "Tailing Nginx logs..."
tail -f $ACCESS_LOG $ERROR_LOG
