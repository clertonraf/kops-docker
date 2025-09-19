# KoPS (Konnektorsimulator für Primärsysteme) Docker Image

KoPS is a Gematik connector simulator for primary healthcare systems, allowing development and testing of healthcare applications without requiring a physical connector.

## Prerequisites

This Docker image includes:

- OpenJDK 11
- KoPS Toolkit from [Gematik Fachportal](https://fachportal.gematik.de/toolkit/kops)
- KoPS Package v3.1.15 (released 21.06.22)

### System Requirements

- Docker and Docker Compose installed
- At least 2GB of RAM available for the container
- Valid KoPS license file (obtain from Gematik)

## Quick Start

### 1. Download the License File

Obtain a valid KoPS license file from Gematik. The license file should be named something like `kops_3.1_mit_ePA__Your_Company.lic`.

### 2. Set Up Environment

Create a `.env` file in your project directory:

```bash
# HTTP port mapping (host:container)
HTTP_PORT=8080

# HTTPS port mapping (host:container)
HTTPS_PORT=443

# Path to your KoPS license file
LICENSE_FILE=./kops_3.1_mit_ePA__Your_Company.lic
```

### 3. Get Docker Compose File

Download the docker-compose.yml file:

```bash
wget https://raw.githubusercontent.com/clertonraf/kops-docker/refs/heads/master/docker-compose.yml
```

Or clone the repository:

```bash
git clone https://github.com/clertonraf/kops-docker.git
cd kops-docker
```

### 4. Start the Application

Run in foreground (with logs visible):

```bash
docker compose up
```

Run in background (detached mode):

```bash
docker compose up -d
```

### 5. Access the Web Interface

Once the application starts (wait ~30-60 seconds for full initialization), access:

- **Web Interface**: http://localhost:8080/KoPS/web/
- **API Documentation**: http://localhost:8080/KoPS/swagger/
- **REST API**: http://localhost:8080/KoPS/

## Platform Compatibility

### Apple Silicon Macs (M1/M2/M3)

The image is built for AMD64 architecture but will run on ARM64 systems through emulation. The docker-compose.yml file includes `platform: linux/amd64` to ensure compatibility.

## Configuration

### Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `HTTP_PORT` | `8080` | Host port for HTTP access |
| `HTTPS_PORT` | `443` | Host port for HTTPS access |
| `LICENSE_FILE` | Required | Path to KoPS license file |

### Port Mapping

- **Host Port 8080** → **Container Port 9090** (HTTP)
- **Host Port 443** → **Container Port 443** (HTTPS)

The application internally runs on port 9090, but is mapped to port 8080 on the host for convenience.

## Troubleshooting

### Common Issues

#### Application Not Loading
- Wait 30-60 seconds after `docker compose up` for full initialization
- Ensure you're accessing the correct URL: `http://localhost:8080/KoPS/web/`
- Check container logs: `docker compose logs kops`

#### Platform Issues on Apple Silicon
- Ensure `platform: linux/amd64` is in docker-compose.yml
- May run slower due to emulation, but functionality should be complete

#### Port Conflicts
- If port 8080 is in use, modify `HTTP_PORT` in your `.env` file
- If port 443 is in use, modify `HTTPS_PORT` in your `.env` file

### Viewing Logs

Check application logs:
```bash
docker compose logs kops
```

Follow logs in real-time:
```bash
docker compose logs -f kops
```

### Container Access

Access the running container for debugging:
```bash
docker exec -it kops /bin/bash
```

Inside the container, logs are available at:
- `/opt/kops/logs/` - Application logs
- KoPS configuration: `/opt/kops/conf/`

## Stopping the Application

Stop the application:
```bash
docker compose down
```

Stop and remove all data:
```bash
docker compose down -v
```

## Development Notes

### Available Services

The KoPS simulator provides various healthcare connector services:
- Card Terminal Service
- Certificate Service
- Event Service
- Signature Service
- VSD Service (Versichertenstammdaten)
- NFDM Service
- ePA Service (Elektronische Patientenakte)
- And more healthcare-specific services

### API Access

- REST API base URL: `http://localhost:8080/KoPS/`
- Swagger documentation: `http://localhost:8080/KoPS/swagger/`
- All standard Gematik connector operations are available

## License

This Docker configuration is provided as-is. You must obtain a valid KoPS license from Gematik to use this software.

## TODO

- [ ] Pre-configured environment with sample data
- [ ] Health check endpoint
- [ ] External log volume configuration
- [ ] TLS/SSL certificate configuration
- [ ] Performance optimization for ARM64 platforms

---

<a href="https://www.buymeacoffee.com/clertonraf" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>
