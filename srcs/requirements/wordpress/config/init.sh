#!/bin/bash
set -e

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

# Wait for MariaDB to be ready
echo "Trying to connect with:  Host: $DB_HOST, User: $DB_USER, Pass: $DB_PASS"

until mysql -h ${DB_HOST} -u ${DB_USER} -p${DB_PASS} -e ""; do
  echo "Waiting for MariaDB..."
  sleep 2
done

echo "MariaDB is ready (from wp cont)"

# Check if wp-config.php exists
if [ ! -f wp-config.php ]; then
  echo "Configuring WordPress..."

  ./wp-cli.phar core download --allow-root

  ./wp-cli.phar config create \
    --dbname=${DB_NAME} \
    --dbuser=${DB_USER} \
    --dbpass=${DB_PASS} \
    --dbhost=${DB_HOST} \
    --allow-root

  ./wp-cli.phar core install \
    --url=${DOMAIN_NAME} \
    --title="Inception" \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PASS} \
    --admin_email=${WP_ADMIN_EMAIL} \
    --allow-root

  # Create additional user (subscriber role like Script 1)
  ./wp-cli.phar user create \
    ${WP_USER} ${WP_USER_EMAIL} \
    --user_pass=${WP_USER_PASS} \
    --role=subscriber \
    --allow-root

  # Set proper permissions (like Script 1)
  chown -R www-data:www-data /var/www/wordpress/wp-content
  chmod -R 775 /var/www/wordpress/wp-content

  # Redis caching setup (like Script 1)
  ./wp-cli.phar config set WP_REDIS_HOST redis --allow-root
  ./wp-cli.phar config set WP_REDIS_PORT 6379 --raw --allow-root
  ./wp-cli.phar config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
  ./wp-cli.phar config set WP_REDIS_CLIENT phpredis --allow-root
  ./wp-cli.phar plugin install redis-cache --activate --allow-root
  ./wp-cli.phar redis enable --allow-root

  # Filesystem method (like Script 1)
  ./wp-cli.phar config set FS_METHOD direct --allow-root

  echo "WordPress installation complete with default setup."
else
  echo "WordPress already configured, skipping installation."
fi

# Run PHP-FPM
exec php-fpm7.4 -F