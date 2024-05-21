# Base image
FROM alpine:3.18

RUN apk update \
    && apk add mariadb-server

EXPOSE 3306

HEALTHCHECK --start-period=5m \
    CMD mariadb -e 'SELECT @@datadir;' || exit 1

CMD ["mariadbd"]
