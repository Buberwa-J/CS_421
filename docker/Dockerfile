# 1. Use the official PHP 8.2 image with Apache
FROM php:8.2-apache

# 2. Set the working directory inside the container
WORKDIR /var/www/html

# 3. Install system dependencies for PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    curl \
    libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# 4. Enable Apache mod_rewrite for Laravel routing
RUN a2enmod rewrite

# 5. Install Composer globally
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 6. Copy your Laravel project files into the container
COPY . .

# 7. Install PHP dependencies
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# 8. Set proper permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage

# 9. Expose port 80 to the outside world
EXPOSE 80

# 10. Set the default command to run Apache
CMD ["apache2-foreground"]
