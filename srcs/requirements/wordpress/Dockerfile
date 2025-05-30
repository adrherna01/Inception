FROM debian:bullseye

# Install dependencies

RUN apt update && apt install -y \
    php-fpm \
    php-mysqli \
    curl \
    wget \
    && apt-get clean


# Create WordPress directory

RUN mkdir -p /var/www/html && \
    mkdir -p /run/php && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

WORKDIR /var/www/html

COPY config/www.conf  /etc/php/7.4/fpm/pool.d/
COPY config/init.sh /init.sh

RUN chmod +x /init.sh

# Expose php-fpm default port
EXPOSE 9000

ENTRYPOINT ["/init.sh"]