# two

1on1 tools

## Requirements

- Docker
- docker-compose

## Requirements

- Docker
- docker-compose

## Setup

```sh
git clone https://github.com/ikuhanarock/two.git
cd two/
sh scripts/setup.sh
```

### Setup Self-signed certification

1. Create self-signed certification
```sh
sh scripts/generate_selfsigned_certs.sh
```
2. Permit to keychain from generated selfsined.crt file(in frontend/certs/ or nginx/certs/ directories)
3. Rebuild nginx container
```sh
docker-compose build nginx
```
4. Restart containers(nginx, frontend)
```sh
docker-compose restart nginx frontend
```
