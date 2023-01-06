FROM php:7.3-fpm-alpine

RUN mkdir -p /app/triolanguage
RUN mkdir -p /var/www/html/

WORKDIR /app/triolanguage

RUN apk update && apk add git

RUN docker-php-ext-install mysqli pdo pdo_mysql

RUN git clone https://github.com/houssambourkane/triolanguage.git /app/triolanguage
