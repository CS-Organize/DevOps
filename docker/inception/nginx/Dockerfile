# Base image
FROM alpine:3.18

RUN apk update && apk add nginx && mkdir -p /var/www/html

# Copy the configuration file
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /var/www/index.html
COPY 404.html /var/www/html/404.html
COPY style.css /var/www/css/style.css

# Port to expose
EXPOSE 80/tcp

CMD ["nginx", "-g", "daemon off;"]
