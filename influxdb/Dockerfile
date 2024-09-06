ARG BASE_IMAGE=2.7.10-alpine

FROM docker.io/influxdb:${BASE_IMAGE}

ARG USER_ID=1000 GROUP_ID=1000

RUN set -ex \
    && ((grep /etc/os-release -e alpine && apk add --no-cache shadow) || true) \
    && usermod -u ${USER_ID} influxdb \
    && groupmod -g ${GROUP_ID} influxdb \
    && ((grep /etc/os-release -e alpine && apk del shadow) || true)

USER influxdb:influxdb
