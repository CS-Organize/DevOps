# Base image
FROM alpine:3.18

RUN apk update \
    && apk add --no-cache nginx openssl \
    && mkdir -p /var/www/html /var/www/css /etc/nginx/ssl \
    && openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=Cadet/CN=localhost"

# Copy the configuration file
COPY conf/default.conf /etc/nginx/http.d/default.conf

# Port to expose, Just documentation(Not necessary)
EXPOSE 443/tcp

CMD ["nginx", "-g", "daemon off;"]
