# KoPS (Konnektorsimulator für Primärsysteme) docker image

## Premisses

This image uses:

- openjdk 11
- Toolkit available at https://fachportal.gematik.de/toolkit/kops
- KoPS-Packet (21.06.22)

## Usage

1. Download the license

2. Create .env file

```
PORT=9090
LICENSE_FILE=./kops_3.1_mit_ePA__My_Company.lic
```

3. Download docker compose file

```bash
wget -c -d https://raw.githubusercontent.com/clertonraf/kops-docker/refs/heads/master/docker-compose.yml
```

4. Run docker compose

```bash
docker compose --env-file .env up
```

- if you want to run in background, use `-d` option

```bash
docker compose --env-file .env up -d
```

5. Access the KoPS at http://localhost:9090/KoPS/web
