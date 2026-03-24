
#!/bin/bash

if [ $1 = "down" ]; then
    echo "Stopping and removing containers..."
    docker compose down
elif [ $1 = "build" ] || [ $1 = "rebuild" ]; then
    echo "Rebuilding and restarting containers..."
    docker compose down
    VENDOR_DIR=./vendor
    if [ ! -d "$VENDOR_DIR" ]; then
        echo "Vendor directory not found. Installing composer dependencies..."
        docker compose up -d
    else
        echo "Vendor directory exists. Remove and reinstalling composer dependencies..."
        rm -rf $VENDOR_DIR
        docker compose up -d --build
    fi
    docker compose exec billing_app composer install
    docker compose exec billing_app php artisan key:generate
    docker compose exec billing_app php artisan storage:link
    docker-compose exec billing_app chmod -R 775 storage bootstrap/cache
    docker-compose exec billing_app chown -R www-data:www-data storage bootstrap/cache

    read -p "Do you want to run database migrations? (y/n) " answer
    if [ "$answer" = "y" ]; then
        echo "Running database migrations..."
        docker compose exec billing_app php artisan migrate --seed
    else
        echo "Skipping database migrations."
    fi
elif [ $1 = "migrate" ]; then
    echo "Running database migrations..."
    docker compose exec billing_app php artisan migrate --seed
elif [ $1 = "rollback" ]; then
    echo "Rolling back the last database migration..."
    docker compose exec billing_app php artisan migrate:rollback
else
    echo "Starting containers..."
    docker compose up -d
fi

