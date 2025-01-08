# Base image
FROM php:8.2-fpm as php

# Environment variables for PHP
ENV PHP_OPCACHE_ENABLE=1 \
    PHP_OPCACHE_ENABLE_CLI=0 \
    PHP_OPCACHE_VALIDATE_TIMESTAMP=1 \
    PHP_OPCACHE_REVALIDATE_FREQ=1

# Adjust permissions for www-data
RUN usermod -u 1000 www-data

# Install dependencies and PHP extensions
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    vim nano libpq-dev zip unzip curl libcurl4-gnutls-dev netcat-openbsd \
    && docker-php-ext-install \
    pdo \
    pdo_pgsql \
    opcache \
    bcmath \
    && docker-php-ext-enable opcache bcmath \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /var/www/html

# Copy application source code
COPY . .



# Copy configuration files
COPY ./php/php.ini /usr/local/etc/php/conf.d/php.ini

# Copy Composer binary
COPY --from=composer:2.8.4 /usr/bin/composer /usr/bin/composer

# Adjust permissions for Laravel directories
RUN chown -R www-data:www-data ./storage ./bootstrap/cache

# Copy and set up the entrypoint script
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set entrypoint
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

# Expose PHP-FPM default port
EXPOSE 9000

CMD ["php-fpm"]

#
