#!/bin/bash

set -e

echo "Starting WordPress setup"

mkdir -p /run/php

cd /var/www/html/wordpress

echo "Checking if WordPress is installed"

if wp core is-installed --allow-root; then
    echo "WordPress is already installed"
else
    echo "Installing WordPress"

    wp core install --url="http://localhost:5050" --title="My WordPress Site" --admin_user=$ADMIN_USER --admin_password="ieusebio1234" --admin_email=$ADMIN_EMAIL --allow-root

    echo "Creating additional user"
    wp user create "ieusebio02" "ieusebio02@example.com" --user_pass="i1234" --role="author" --allow-root


    wp user list --allow-root
    if [ $? -eq 0 ]; then
        echo "WordPress installed successfully"
    else
        echo "Failed to install WordPress"
        exit 1
    fi
fi

echo "WordPress setup completed"
echo "Starting PHP-FPM"

exec php-fpm8.2 -F