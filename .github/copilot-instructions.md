# KoPS Docker Project Instructions

## Project Overview
This project containerizes KoPS (Konnektorsimulator für Primärsysteme), a German healthcare connector simulator from Gematik. It packages the KoPS toolkit with OpenJDK 11 for easy deployment and testing of healthcare integrations.

## Architecture & Components

### Core Container Setup
- **Base**: OpenJDK 11 slim image
- **KoPS Source**: Downloaded from `https://fachportal.gematik.de/fileadmin/Fachportal/Tool-Kit/KoPs/KoPS31_ohne_OpenJDK_V3.1.15_20220621.zip`
- **Working Directory**: `/opt/kops` inside container
- **Entry Point**: `/opt/kops/start.sh` script (extracted from KoPS package)

### Port Configuration Pattern
- **Current**: Exposes both HTTP (8080) and HTTPS (443) ports
- **Previous**: Used single configurable port via `$PORT` environment variable (9090 default)
- **Docker Compose**: Maps container ports to host via `${HTTP_PORT:-8080}` and `${HTTPS_PORT:-443}` env vars

### License Management
- **Critical**: KoPS requires a valid `.lic` file to function
- **Mount Pattern**: License file mounted as volume to `/opt/kops/kops.lic`
- **Environment**: `LICENSE_FILE` variable points to host license file path
- **Gitignore**: All `.lic` files are excluded from version control

## Development Workflows

### Local Development Setup
```bash
# 1. Create .env file with required variables
echo "HTTP_PORT=8080\nHTTPS_PORT=443\nLICENSE_FILE=./your-license.lic" > .env

# 2. Run with docker-compose
docker compose --env-file .env up

# 3. Access KoPS web interface at http://localhost:8080/KoPS/web
```

### Container Access & Debugging
```bash
# Access running container for log inspection
docker exec -it kops /bin/bash

# Key paths inside container:
# - /opt/kops/start.sh (startup script)
# - /opt/kops/kops.lic (mounted license)
# - /opt/kops/ (extracted KoPS application)
```

### CI/CD Pipeline
- **Trigger**: Pushes to any branch
- **Registry**: Docker Hub (`clertonraf/kops-docker:latest`)
- **Process**: Build → Test run → Push
- **Requirements**: `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` secrets

## Project-Specific Conventions

### Environment Configuration
- Use `.env` file pattern for local development
- Default ports: HTTP=8080, HTTPS=443 (fallback values in docker-compose)
- License file path must be relative to docker-compose location

### Branch Strategy
- `master`: Stable releases
- `expose_https_port`: Current feature branch adding HTTPS support
- Changes involve both `Dockerfile` EXPOSE statements and `docker-compose.yml` port mappings

### File Naming
- License files follow pattern: `kops_<version>_mit_ePA__<company>_<id>.lic`
- Environment files: Standard `.env` format
- Docker assets: Standard `Dockerfile` and `docker-compose.yml`

## Integration Points

### External Dependencies
- **Gematik Fachportal**: Source for KoPS toolkit downloads
- **Docker Hub**: Image registry for distribution
- **License Provider**: Gematik-issued license files required for operation

### Healthcare Context
- KoPS simulates German healthcare connectors for ePA (elektronische Patientenakte)
- Used for testing healthcare system integrations without real infrastructure
- Compliance with German healthcare IT standards and regulations