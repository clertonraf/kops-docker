# KoPS (Konnektorsimulator für Primärsysteme) docker image

## Premisses

In this image:

- openjdk 11
- Toolkit available at [https://fachportal.gematik.de/toolkit/kops](https://fachportal.gematik.de/toolkit/kops)
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

5. Access the KoPS at [hhtp://localhost:9090/Kops/web](http://localhost:9090/KoPS/web)

## Accessing the container

By accessing the container, you can check the logs and other files

```bash
docker exec -it kops /bin/bash
```

## TODO

- [ ] Pre-configured environment
- [ ] Healthcheck
- [ ] TLS support
- [ ] External log access
