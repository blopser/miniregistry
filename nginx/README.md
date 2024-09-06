# Description
For full description official documentation: https://hub.docker.com/_/nginx

# Basic usage
```bash
docker build . --tag nginx
docker run --rm --name=nginx -p 8080:8081 -e NGINX_PORT=8081 -e NGINX_STATIC_URL='/' -v ./conf/default-static.conf.template:/etc/nginx/templates/default.conf.template -v ./conf:/var/www/static -u $UID nginx
```
or from registry
```
docker run --rm --name=nginx -p 8080:8081 -e NGINX_PORT=8081 -e NGINX_STATIC_URL='/' -v ./conf/default-static.conf.template:/etc/nginx/templates/default.conf.template -v ./conf:/var/www/static -u $UID ghcr.io/blopser/nginx:latest
```
or using docker-compose
```bash
docker-compose build && podman-compose down && docker-compose up
```

# Environment variables
- `NGINX_PORT` - listen port, 8080 by default. Uses nginx template (for example `default-static.conf.template`)
Additional environment variables can be used in conf files. See environment vairables section in official nginx documentation

# Volumes
You can mount files `/etc/nginx/nginx.conf`, `/etc/nginx/conf.d/default.conf` or `/etc/nginx/templates` if you want to change your server configuration.

# Build arguments
Can be used by ```docker build --build-arg="UID=1002" . --tag nginx```
- `UID = 1000`, `GID = 1000` - patched user id and group id.
- `BASE_IMAGE=1.27-alpine3.20` - base image.
