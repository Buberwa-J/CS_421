# Stage 1: Use Composer
FROM composer:2.6 AS composer_stage
WORKDIR /app
COPY ./app /app
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Stage 2: Apache + PHP
FROM php:8.2-apache

# Install required PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    nano \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    && docker-php-ext-install pdo pdo_mysql mbstring zip

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www

# Copy app code and composer-installed vendor
COPY --from=composer_stage /app /var/www

# Permissions
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www

EXPOSE 80
