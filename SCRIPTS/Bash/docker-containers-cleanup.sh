#!/bin/bash
# Docker Cleanup Script

echo "Removing stopped containers..."
docker container prune -f

echo "Removing dangling images..."
docker image prune -f

echo "Removing unused volumes..."
docker volume prune -f

echo "Docker cleanup completed!"
