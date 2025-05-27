#!/bin/bash
set -e

# Start MariaDB in the background
mysqld_safe &

# Wait for MariaDB to be ready
until mysqladmin ping --silent; do
  echo "Waiting for MariaDB..."
  sleep 2
done

# Run the init script
/init.sh

echo "Init script finished"
# Keep MariaDB running in foreground
wait