#!/bin/bash
set -e

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

# Check if wp-config.php exists
if [ ! -f wp-config.php ]; then
  echo "Configuring WordPress..."

./wp-cli.phar core download --allow-root --force

  echo "block 1"
  ./wp-cli.phar config create \
    --dbname=${DB_NAME} \
    --dbuser=${DB_USER} \
    --dbpass=${DB_PASS} \
    --dbhost=${DB_HOST} \
    --allow-root
  echo "block 2"
  ./wp-cli.phar core install \
    --url=${DOMAIN_NAME} \
    --title="Inception" \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PASS} \
    --admin_email=${WP_ADMIN_EMAIL} \
    --allow-root

  # Create additional user (subscriber role like Script 1)
  echo "block 3"
  ./wp-cli.phar user create \
    ${WP_USER} ${WP_USER_EMAIL} \
    --user_pass=${WP_USER_PASS} \
    --role=subscriber \
    --allow-root

  echo "block 4"
  # Set proper permissions (like Script 1)
  chown -R www-data:www-data /var/www/wordpress/wp-content
  chmod -R 775 /var/www/wordpress/wp-content

  echo "block 6"
  # Filesystem method (like Script 1)
  ./wp-cli.phar config set FS_METHOD direct --allow-root

  echo "WordPress installation complete with default setup."
else
  echo "WordPress already configured, skipping installation."
fi

# Run PHP-FPM
exec php-fpm7.4 -F