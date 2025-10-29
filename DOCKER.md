# Docker Deployment Guide

This document explains how to build and run the application using Docker.

## Prerequisites

- Docker installed on your system
- Docker Compose installed (usually comes with Docker Desktop)

## Quick Start

### Using Docker Compose (Recommended)

1. Build and start the application:
```bash
docker compose up -d
```

2. Access the application at `http://localhost`

3. Stop the application:
```bash
docker compose down
```

### Using Docker Directly

1. Build the image:
```bash
docker build -t gdg-certs-frontend .
```

2. Run the container:
```bash
docker run -d -p 80:80 --name gdg-certs gdg-certs-frontend
```

3. Stop and remove the container:
```bash
docker stop gdg-certs
docker rm gdg-certs
```

## Configuration

### Environment Variables

You can pass environment variables to the container:

```yaml
services:
  frontend:
    environment:
      - NODE_ENV=production
      - VITE_API_URL=https://api.example.com
```

### Custom Port

To run on a different port, modify `docker-compose.yml`:

```yaml
ports:
  - "8080:80"  # Changed from 80:80
```

## Development

For development, it's recommended to use the local development server instead of Docker:

```bash
npm install
npm run dev
```

## Key Changes from Error Message

The original error showed:
1. **Missing `package-lock.json` with `npm ci`** - Fixed by:
   - Using `npm install` instead of `npm ci` in Dockerfile
   - This works whether or not package-lock.json exists
   - Adds `--prefer-offline --no-audit` flags for better reliability
2. **Obsolete `version` attribute** - Removed from `docker-compose.yml` (no longer required in Compose v2+)
3. **Separate backend/frontend structure** - Simplified to single frontend service
4. **Node version incompatibility** - Updated from Node 18 to Node 20 (required for Vite 7)

## Architecture

- **Multi-stage build**: Reduces final image size
- **Node 20 Alpine**: Lightweight base image for building
- **Nginx Alpine**: Efficient production server
- **Health checks**: Built-in container health monitoring

## Troubleshooting

### Port Already in Use

If port 80 is already in use:
```bash
docker compose down
# Edit docker-compose.yml to use different port
docker compose up -d
```

### Build Failures

Clear Docker cache and rebuild:
```bash
docker compose down
docker system prune -af
docker compose up -d --build
```

### View Logs

```bash
docker compose logs -f frontend
```
