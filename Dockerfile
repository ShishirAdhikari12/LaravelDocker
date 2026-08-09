FROM php:8.1 AS php

RUN apt-get update -y
RUN apt-get install -y unzip libpq-dev libcurl4-gnutls-dev
RUN docker-php-ext-install pdo pdo_mysql bcmath

RUN pecl install -o -f redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis

WORKDIR /var/www
COPY . .
RUN chmod +x docker/entrypoint.sh
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

ENV PORT=8000
ENTRYPOINT [ "docker/entrypoint.sh" ]


#==========================================================
# node
FROM node:24-alpine AS node

WORKDIR /var/www
COPY . .

RUN npm install --globle cross-env
RUN npm install

VOLUME /var/www/node_modules