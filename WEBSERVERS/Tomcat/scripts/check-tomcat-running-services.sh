#!/bin/bash

# Check Tomcat Running Status

PORT=8080
echo "Checking if Tomcat is running on port $PORT..."
netstat -tuln | grep :$PORT && echo "Tomcat is running!" || echo "Tomcat is not running!"
