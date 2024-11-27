#!/bin/bash

# Health Check Script

echo "Server Health Check: $(date)"

# CPU usage
echo "CPU Usage:"
mpstat | grep -A 5 "%idle" | tail -n 1

# Memory usage
echo "Memory Usage:"
free -h

# Disk usage
echo "Disk Usage:"
df -h | grep -vE '^Filesystem|tmpfs|cdrom'

echo "Health check completed!"
