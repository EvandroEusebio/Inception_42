#!/bin/bash

set -e

echo "Starting script.sh"

echo "Creating /run/mysqld directory and setting permissions"

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

echo "Starting MariaDB"

mariadbd --skip-networking &

until mariadb-admin ping --silent; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done

echo "MariaDB started successfully"


echo "Configuring MariaDB"

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory"
    mariadb-install-db 
fi

echo "db name: $DB_NAME"
echo "db user: $DB_USER"

mariadb -u root << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY 'wordpress1234';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES;
EOF

mariadb-admin -u root shutdown

echo "MariaDB configuration complete."

exec mariadbd