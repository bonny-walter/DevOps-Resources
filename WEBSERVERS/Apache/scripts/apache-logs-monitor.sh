#!/bin/bash

# Monitor Apache Logs

ACCESS_LOG="/var/log/apache2/access.log"
ERROR_LOG="/var/log/apache2/error.log"

echo "Tailing Apache logs..."
tail -f $ACCESS_LOG $ERROR_LOG
