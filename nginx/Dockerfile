ARG BASE_IMAGE=1.27-alpine3.20

FROM docker.io/nginx:${BASE_IMAGE}

ARG UID=1000
ARG GID=1000
ENV NGINX_PORT=8080

COPY start.sh /
COPY \
    ./docker-entrypoint.d/10-listen-on-ipv6-by-default.sh \
    ./docker-entrypoint.d/20-envsubst-on-templates.sh \
    ./docker-entrypoint.d/30-tune-worker-processes.sh \
    /docker-entrypoint.d
COPY nginx.conf /etc/nginx/nginx.conf

RUN set -ex \
    && chown -R $UID:0 /var/cache/nginx \
    && chmod -R g+w /var/cache/nginx \
    && chown -R $UID:0 /etc/nginx \
    && chmod -R g+w /etc/nginx

ENTRYPOINT ["/start.sh"]

EXPOSE ${NGINX_PORT}

STOPSIGNAL SIGQUIT

USER $UID

CMD ["nginx", "-g", "daemon off;"]
