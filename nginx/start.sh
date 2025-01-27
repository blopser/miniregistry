#!/bin/sh

set -e

if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
    exec 3>&1
else
    exec 3>/dev/null
fi

if [ "$1" = "nginx" -o "$1" = "nginx-debug" ]; then
    if /usr/bin/find "/docker-entrypoint.d/" -mindepth 1 -maxdepth 1 -type f -print -quit 2>/dev/null | read v; then
        [ "$NGINX_STARTUP_LOG" = "true" ] && echo >&3 "$0: /docker-entrypoint.d/ is not empty, will attempt to perform configuration"

        [ "$NGINX_STARTUP_LOG" = "true" ] && echo >&3 "$0: Looking for shell scripts in /docker-entrypoint.d/"
        find "/docker-entrypoint.d/" -follow -type f -print | sort -V | while read -r f; do
            case "$f" in
                *.sh)
                    if [ -x "$f" ]; then
                        [ "$NGINX_STARTUP_LOG" = "true" ] && echo >&3 "$0: Launching $f";
                        "$f"
                    else
                        # warn on shell scripts without exec bit
                        [ "$NGINX_STARTUP_LOG" = "true" ] && echo >&3 "$0: Ignoring $f, not executable";
                    fi
                    ;;
                *) [ "$NGINX_STARTUP_LOG" = "true" ] && echo >&3 "$0: Ignoring $f"
                   ;;
            esac
        done

        [ "$NGINX_STARTUP_LOG" = "true" ] && echo >&3 "$0: Configuration complete; ready for start up"
    else
        [ "$NGINX_STARTUP_LOG" = "true" ] && echo >&3 "$0: No files found in /docker-entrypoint.d/, skipping configuration"
    fi
fi

exec "$@"
