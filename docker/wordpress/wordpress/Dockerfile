FROM php:8.1-apache

RUN apt-get update
RUN apt-get install apache2 \
    ghostscript \
    libapache2-mod-php \
    mysql-server \
    php \
    php-bcmath \
    php-curl \
    php-imagick \
    php-intl \
    php-json \
    php-mbstring \
    php-mysql \
    php-xml \
    php-zip

WORKDIR /srv/www
RUN chown www-data: /srv/www
RUN curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www

