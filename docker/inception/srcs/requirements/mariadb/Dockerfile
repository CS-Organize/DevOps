# https://github.com/yobasystems/alpine-mariadb/blob/master/alpine-mariadb-aarch64/Dockerfile
FROM alpine:3.19

RUN apk update && \
    apk add --no-cache mariadb mariadb-client mariadb-server-utils && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /scripts /var/log/mysql/ && \
    touch /var/log/mysql/error.log && \
    chown -R mysql:mysql /var/log/mysql/

COPY tools/run.sh /scripts/run.sh
COPY conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

RUN chmod -R 755 /scripts

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/scripts/run.sh"]
