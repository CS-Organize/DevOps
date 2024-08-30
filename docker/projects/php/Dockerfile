FROM alpine:latest

RUN apk update && \
    apk add --no-cache openrc php php-fpm php-mbstring &&\
    mkdir -p /var/www/html/

WORKDIR /var/www/html

COPY index.php .

EXPOSE 8000

CMD ["php", "-S", "0.0.0.0:8000", "-t", "/var/www/html"]

