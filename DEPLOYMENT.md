# Deployment Guide

## Development

Run with live code reload and debug enabled:

```bash
docker compose up
```

The `develop.watch` configuration in `docker-compose.yml` syncs code changes instantly without rebuilding the container. Templates and `app.py` are live-synced. Changing `requirements.txt` triggers a rebuild.

Access the app at `http://localhost:5000`

## Production

Run with optimized settings and resource limits:

```bash
docker compose -f docker-compose.prod.yml up -d
```

Production settings:
- No bind mounts (immutable container)
- Resource limits: 1 CPU / 512MB max memory
- Restart policy: always
- Debug mode: disabled

## Build

Build the image:

```bash
docker build -t mood-tracker:latest .
```

## Health Checks

Both configurations include health checks that run every 30 seconds. The container automatically restarts if unhealthy.

Check container health:

```bash
docker inspect --format='{{.State.Health.Status}}' mood-tracker-app
```

## Data Persistence

Mood data is stored in a Docker named volume (`mood_data`) at `/app/data`. This persists across container restarts and removals.

View volume information:

```bash
docker volume inspect mood_data
```

## Docker Best Practices Used

✓ Multi-stage builds - smaller production image (builder stage discarded)
✓ Non-root user - runs as `appuser` (UID 1000) for security
✓ Minimal base image - `python:3.11-slim` reduces attack surface
✓ Layer caching - requirements copied separately before app code
✓ Health checks - automatic container restart on failure
✓ Environment variables - configuration via ENV
✓ .dockerignore - excludes unnecessary files from build context
✓ Persistent volumes - data survives container restarts
✓ Resource limits - production compose enforces CPU/memory caps
✓ Development watch - hot reload without container rebuild

## Troubleshooting

Check logs:

```bash
docker compose logs mood-tracker
```

Rebuild image:

```bash
docker compose down
docker compose build --no-cache
docker compose up
```

Clean up volumes (warning: deletes data):

```bash
docker volume rm mood_data
```
