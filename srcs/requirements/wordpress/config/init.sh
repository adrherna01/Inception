#!/bin/bash
set -e

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

# Check if wp-config.php exists
if [ ! -f wp-config.php ]; then
  echo "Configuring WordPress..."

  ./wp-cli.phar core download --allow-root --force

  ./wp-cli.phar config create \
    --dbname=${DB_NAME} \
    --dbuser=${DB_USER} \
    --dbpass=${DB_PASS} \
    --dbhost=${DB_HOST} \
    --allow-root

  ./wp-cli.phar core install \
    --url="https://${DOMAIN_NAME}" \
    --title="Inception" \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PASS} \
    --admin_email=${WP_ADMIN_EMAIL} \
    --allow-root

  ./wp-cli.phar theme install twentytwentyfour --activate --allow-root

  # Update siteurl and home explicitly (like first script)
  ./wp-cli.phar option update siteurl "https://${DOMAIN_NAME}" --allow-root
  ./wp-cli.phar option update home "https://${DOMAIN_NAME}" --allow-root

  chown -R www-data:www-data /var/www/html/wp-content
	chmod -R 0777 /var/www/html/wp-content

  # Create additional user (subscriber role like Script 1)
  ./wp-cli.phar user create \
    ${WP_USER} ${WP_USER_EMAIL} \
    --user_pass=${WP_USER_PASS} \
    --role=subscriber \
    --allow-root

  # Set proper permissions (like Script 1)
  chown -R www-data:www-data /var/www/html/wp-content
  chmod -R 0777 /var/www/html/wp-content

  # Filesystem method (like Script 1)
  ./wp-cli.phar config set FS_METHOD direct --allow-root

  # Update all plugins (like first script)
  # ./wp-cli.phar plugin update --all --allow-root

  echo "WordPress installation complete with default setup."
else
  echo "WordPress already configured, skipping installation."
fi

# Run PHP-FPM
exec php-fpm7.4 -F
