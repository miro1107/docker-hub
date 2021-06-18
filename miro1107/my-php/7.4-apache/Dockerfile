FROM php:7.4-apache

# enable apache rewrite mod
ENV APACHE_CONFDIR /etc/apache2
RUN ln -s ../mods-available/rewrite.load "$APACHE_CONFDIR/mods-enabled/rewrite.load"

# install mysqli and pdo_mysql ext
RUN docker-php-ext-install mysqli \
    && docker-php-ext-install pdo_mysql

# install gd ext
RUN apt-get update \
    && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

