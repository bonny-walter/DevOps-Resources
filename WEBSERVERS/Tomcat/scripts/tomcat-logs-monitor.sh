#!/bin/bash
# Monitor Tomcat Logs

TOMCAT_HOME="/opt/tomcat"
LOG_FILE="$TOMCAT_HOME/logs/catalina.out"

echo "Tailing Tomcat logs..."
tail -f $LOG_FILE
