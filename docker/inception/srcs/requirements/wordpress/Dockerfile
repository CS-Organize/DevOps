# https://github.com/docker-library/wordpress/blob/2eba26f088c12dea179623ee8af5cb52e6f60c4a/latest/php8.1/fpm-alpine/Dockerfile
FROM alpine:3.18

EXPOSE 9000

RUN apk update && \
    apk add --no-cache git php-fpm php-mysqli php-mysqlnd
    
RUN wget https://wordpress.org/latest.tar.gz -O /tmp/latest.tar.gz && \
    mkdir -p /var/www/html && \
    tar -xzf /tmp/latest.tar.gz && \
    mv wordpress/* /var/www/html/ && \
    rm -f /tmp/latest.tar.gz && \
    mkdir wp-content && \
    chmod -R 1777 wp-content
    
COPY conf/www.conf /etc/php81/php-fpm.d/www.conf
COPY conf/php.ini /etc/php81/php.ini

VOLUME /var/www/html

CMD ["php-fpm81", "-F"]
