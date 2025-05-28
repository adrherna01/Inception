#!/bin/bash
set -e

echo "Trying to create db with :  DB_name: $DB_NAME, User: $DB_USER, Pass: $DB_PASS"

mysql -u root <<-EOSQL
    CREATE DATABASE IF NOT EXISTS ${DB_NAME};
    CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
    GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL