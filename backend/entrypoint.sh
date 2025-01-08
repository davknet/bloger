#!/bin/bash
set -e

# Log helper
log() {
  echo "[$(date +"%Y-%m-%d %H:%M:%S")] $@"
}

log "Starting backend container..."

# Ensure dependencies are installed
if [ ! -f "vendor/autoload.php" ]; then
    log "Installing Composer dependencies..."
    composer install --no-progress --no-interaction
fi

# Ensure .env file exists
if [ ! -f ".env" ]; then
    log "Creating .env file..."
    cp .env.example .env
fi

# Wait for the database to be ready
log "Waiting for database connection..."
until nc -z -v -w30 database 5432; do
   log "Waiting for PostgreSQL..."
   sleep 1
done
log "Database is up and running!"

# Run Laravel setup commands

log "Running database migrations..."
php artisan migrate --force
log "Clearing Laravel caches..."
php artisan config:clear
php artisan cache:clear

log "Running database migrations..."


# Start PHP-FPM
log "Starting PHP-FPM..."
exec php-fpm
