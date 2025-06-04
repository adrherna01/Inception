#!/bin/bash
set -e

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

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

  ./wp-cli.phar option update siteurl "https://${DOMAIN_NAME}" --allow-root
  ./wp-cli.phar option update home "https://${DOMAIN_NAME}" --allow-root

  chown -R www-data:www-data /var/www/html/wp-content
	chmod -R 0777 /var/www/html/wp-content

  ./wp-cli.phar user create \
    ${WP_USER} ${WP_USER_EMAIL} \
    --user_pass=${WP_USER_PASS} \
    --role=subscriber \
    --allow-root

  chown -R www-data:www-data /var/www/html/wp-content
  chmod -R 0777 /var/www/html/wp-content

  ./wp-cli.phar config set FS_METHOD direct --allow-root

  echo "WordPress installation complete with default setup."
else
  echo "WordPress already configured, skipping installation."
fi

exec php-fpm7.4 -F
