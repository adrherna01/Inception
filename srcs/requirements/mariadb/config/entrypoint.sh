#!/bin/bash
set -e

# Start MariaDB in the background

if [ -f /var/lib/mysql/.initialized ]; then
	echo "Database already initialized. Skipping setup."
	exec mysqld --user=mysql --console
fi

mysqld_safe --skip-networking &

# Wait for MariaDB to be ready
until mysqladmin ping --silent; do
  echo "Waiting for MariaDB..."
  sleep 2
done

echo "Trying to create db with :  DB_name: $DB_NAME, User: $DB_USER, Pass: $DB_PASS"

mysql -u root <<-EOSQL
    ALTER USER 'root'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('${DB_ROOT_PASS}');
    CREATE DATABASE IF NOT EXISTS ${DB_NAME};
    CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
    GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL

echo "Database has been created"

touch /var/lib/mysql/.initialized

mysqladmin -u root -p${DB_ROOT_PASS} shutdown

exec mysqld --user=mysql --console

echo "MariaDB is now ready for connections"