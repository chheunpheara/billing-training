FROM php:8.4-fpm

WORKDIR /var/www/billing

RUN apt update -y

RUN apt install mariadb-client zlib1g-dev libjpeg-dev libpng-dev libfreetype6-dev libpng-dev libzip-dev git zip unzip vim libicu-dev -y
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install mysqli gd zip intl pdo_mysql exif
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer