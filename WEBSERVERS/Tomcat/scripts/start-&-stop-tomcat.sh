#!/bin/bash

# Start/Stop Tomcat Server

TOMCAT_HOME="/opt/tomcat"
ACTION=$1

if [ "$ACTION" == "start" ]; then
    echo "Starting Tomcat server..."
    $TOMCAT_HOME/bin/startup.sh
elif [ "$ACTION" == "stop" ]; then
    echo "Stopping Tomcat server..."
    $TOMCAT_HOME/bin/shutdown.sh
else
    echo "Usage: $0 {start|stop}"
fi
