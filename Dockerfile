FROM php:7.3-apache

### Install OS tools
RUN apt-get update && apt-get install --yes curl git libmcrypt-dev libreadline-dev libzip-dev

### Install PHP extras
RUN pecl install mcrypt-1.0.2
RUN apt-get update && apt-get install -y \
        zlib1g-dev \
        libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) zip pdo pdo_mysql \
    && docker-php-ext-enable mcrypt

### Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/bin/composer \
    && chmod +x /usr/bin/composer

### Installl Node
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt-get install --yes nodejs

RUN npm install gulp bower -g
