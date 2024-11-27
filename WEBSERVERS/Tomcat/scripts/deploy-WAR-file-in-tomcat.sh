#!/bin/bash

# Deploy WAR to Tomcat

TOMCAT_HOME="/opt/tomcat"
WAR_FILE="/path/to/app.war"
APP_NAME="myapp"

echo "Deploying $WAR_FILE to Tomcat..."

sudo cp $WAR_FILE $TOMCAT_HOME/webapps/$APP_NAME.war
echo "Deployment completed. Restarting Tomcat..."
$TOMCAT_HOME/bin/shutdown.sh
sleep 5
$TOMCAT_HOME/bin/startup.sh
