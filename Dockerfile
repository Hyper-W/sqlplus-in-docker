# Oracle Linux Version
ARG OL_VERSION=8

FROM oraclelinux:${OL_VERSION}

# Your Property
ARG USER=user
ARG USER_ID=1000
ARG GROUP_ID=1000

# Oracle Linux Version
ARG OL_VERSION=8

# Oracle Database Character Encoding
# ENV NLS_LANG=Japanese_Japan.JA16SJISTILDE

# DB Connection String
ENV DB_USERNAME=user
ENV DB_PASSWORD=password
ENV DB_HOST=ip
ENV DB_PORT=1521
ENV DB_SERVICE=service
# Build Connection String OR Override Connection String
ENV CONNECTION_STRING=${DB_USERNAME}/${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_SERVICE}

# Exec SQL File
ENV SQL_NAME=sqlfilename.sql

RUN dnf install -y oracle-instantclient-release-el${OL_VERSION} \
    && dnf install -y oracle-instantclient-basic oracle-instantclient-sqlplus \
    && groupadd -g ${GROUP_ID} ${USER} \
    && useradd -u ${USER_ID} -m -s /bin/bash -g ${USER} ${USER}

USER ${USER}

VOLUME [ "/workdir" ]

WORKDIR /workdir

CMD [ "sqlplus","${CONNECTION_STRING}","@${SQL_NAME}" ]