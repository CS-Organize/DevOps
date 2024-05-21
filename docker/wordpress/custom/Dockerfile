FROM alpine:3.18

EXPOSE 80

RUN apk update && \
    apk add nginx php-fpm php-mysqli && \
    mkdir -p /run/nginx

COPY default.conf /etc/nginx/http.d/default.conf

CMD ["/bin/sh", "-c", "/usr/sbin/php-fpm*; exec nginx -g 'daemon off;';"]

WORKDIR /var/www/localhost/htdocs
