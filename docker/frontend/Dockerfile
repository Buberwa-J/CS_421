FROM php:8.2-apache

# Install dependencies
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

# Enable Apache mod_rewrite (Laravel needs it)
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy Laravel files (we’ll copy this in docker-compose)
COPY . .

# Give permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80
