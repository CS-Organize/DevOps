FROM alpine:3.18

EXPOSE 80

RUN apk update && \
    apk add --no-cache nginx

# COPY default.conf /etc/nginx/http.d/default.conf

CMD ["nginx", "-g", "daemon off;"]

# WORKDIR /var/www/localhost/htdocs
