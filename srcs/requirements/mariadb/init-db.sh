#!/bin/sh

# Start MariaDB service temporarily
service mysql start

# Create database and user
mysql -u root -e "
    CREATE DATABASE IF NOT EXISTS $DB_NAME;
    CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
    GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$DB_USER'@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';
    FLUSH PRIVILEGES;"
