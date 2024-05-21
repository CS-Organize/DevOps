# Base image
FROM alpine:3.18

RUN apk update && \
    apk add --no-cache git php-fpm

CMD ["php-fpm"]
