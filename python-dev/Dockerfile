# syntax=docker/dockerfile:1

ARG BASE_IMAGE=3.12-slim-bullseye

FROM docker.io/library/python:${BASE_IMAGE}

ARG SYS_REQUIREMENTS=__DEFAULT__

RUN set -ex \
    && if (grep /etc/os-release -q -e alpine); then \
        apk add --no-cache bash $(if [ $SYS_REQUIREMENTS = '__DEFAULT__' ]; then echo ""; else echo $SYS_REQUIREMENTS; fi) \
    ; fi \
    && if (grep /etc/os-release -q -e "ubuntu\|debian"); then \
        apt-get update \
        && apt-get install -y $(if [ $SYS_REQUIREMENTS = '__DEFAULT__' ]; then echo "curl gcc vim make git wget cmake"; else echo $SYS_REQUIREMENTS; fi) \
        && rm -rf /var/lib/apt/lists/* \
    ; fi

ARG UNAME=user USER_ID=1000 GROUP_ID=1000

RUN set -ex \
    && if (grep /etc/os-release -q -e alpine); then \
        addgroup -g $GROUP_ID $UNAME \
        && adduser --shell /bin/bash --home /home/$UNAME -u $USER_ID -G "$UNAME" $UNAME --disabled-password \
    ; fi \
    && if (grep /etc/os-release -q -e "ubuntu\|debian"); then \
        groupadd -g $GROUP_ID -o $UNAME \
        && useradd --create-home --shell /bin/bash --home /home/$UNAME \
            -u $USER_ID -g $GROUP_ID $UNAME \
    ; fi

USER $UNAME
RUN mkdir /home/$UNAME/app
WORKDIR /home/$UNAME/app

ENV PYTHONUNBUFFERED=1 \
    VIRTUAL_ENV=/home/$UNAME/app/venv \
    PATH=/home/$UNAME/app/venv/bin:$PATH \
    TERM=xterm-256color

COPY ./start.sh /etc/start.sh

ENTRYPOINT ["/bin/bash", "/etc/start.sh"]
