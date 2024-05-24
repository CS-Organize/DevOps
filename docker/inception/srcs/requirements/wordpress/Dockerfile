# https://github.com/docker-library/wordpress/blob/2eba26f088c12dea179623ee8af5cb52e6f60c4a/latest/php8.1/fpm-alpine/Dockerfile
# https://wiki.alpinelinux.org/wiki/WordPress
# https://docs.rockylinux.org/guides/web/php/
# https://www.php.net/manual/en/mysqli.overview.php
# https://dev.mysql.com/downloads/connector/php-mysqlnd/
# https://inpa.tistory.com/entry/PHP-%F0%9F%93%9A-DB-%EB%8B%A4%EB%A3%A8%EA%B8%B0-mysqli-%EB%B0%A9%EC%8B%9D
FROM alpine:3.19

RUN apk update && \
apk add --no-cache php-fpm php-mysqli git

RUN wget https://wordpress.org/latest.tar.gz -O /tmp/latest.tar.gz && \
    tar -xzf /tmp/latest.tar.gz && \
    mkdir -p /var/www/html && \
    mv wordpress/* /var/www/html/ && \
    rm -f /tmp/latest.tar.gz

COPY conf/www.conf /etc/php82/php-fpm.d/www.conf
COPY conf/php.ini /etc/php82/php.ini

EXPOSE 9000

VOLUME /var/www/html

CMD ["php-fpm82", "-F"]
