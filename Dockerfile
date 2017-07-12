FROM php:7.1.3-apache

### Install OS tools
RUN apt-get update && apt-get install --yes curl git

### Install PHP extras
RUN apt-get update && apt-get install -y \
        zlib1g-dev \
        libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) zip mcrypt pdo pdo_mysql

### Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/bin/composer \
    && chmod +x /usr/bin/composer

### Installl Node
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash
RUN apt-get install --yes nodejs

RUN npm install gulp bower -g
