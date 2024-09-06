# Description
Can be used in rootless mode.

For full description official documentation: https://hub.docker.com/_/influxdb

# Usage example
If you need not default build arguments, download Dockerfile from github and build it:
```
wget https://raw.githubusercontent.com/blopser/miniregistry/main/influxdb/Dockerfile -O Dockerfile-influxdb
```

# Build arguments
- `USER_ID`, `GROUP_ID` - patched user id and group id. Set it to your actual user id if you have problems with volumes permissions on your host machine
- `BASE_IMAGE=2.7.10-alpine` - base image.
