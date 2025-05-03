# Stage 1: Composer build
FROM composer:2.6 AS composer_stage
WORKDIR /app
COPY . /app
RUN composer install --no-interaction

# Stage 2: Apache with PHP
FROM php:8.2-apache

# Install system and PHP dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    nano \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    libzip-dev \
    && docker-php-ext-configure zip \
    && docker-php-ext-install pdo pdo_mysql mbstring zip

# Enable Apache rewrite module
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www

# Copy application from previous stage
COPY --from=composer_stage /app /var/www

# Fix permissions
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www

EXPOSE 80
