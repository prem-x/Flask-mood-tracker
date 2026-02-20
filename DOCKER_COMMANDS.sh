#!/bin/bash
# Docker commands reference for Mood Tracker

# Development: Build and run with hot-reload
docker compose up --build

# Production: Build and run with resource limits
docker compose -f docker-compose.prod.yml up --build -d

# View logs
docker compose logs -f mood-tracker

# Stop containers
docker compose down

# Clean up (removes containers, networks, volumes)
docker compose down -v

# Build image only
docker build -t mood-tracker:latest .

# Push to registry (replace YOUR_REGISTRY)
docker tag mood-tracker:latest YOUR_REGISTRY/mood-tracker:latest
docker push YOUR_REGISTRY/mood-tracker:latest

# View running containers
docker ps

# Access container shell
docker exec -it mood-tracker-app /bin/bash

# View image layers and sizes
docker history mood-tracker:latest
