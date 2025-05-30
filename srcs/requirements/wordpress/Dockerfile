FROM debian:bullseye

# Install dependencies

RUN apt update && apt install -y \
    php-fpm \
    php-mysqli \
    curl \
    wget \
    && apt-get clean


# Create WordPress directory
WORKDIR /var/www/wordpress

# Download WordPress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 && \
    rm latest.tar.gz


RUN mkdir /run/php

COPY config/www.conf /etc/php/7.4/fpm/pool.d/.
COPY config/init.sh /init.sh

RUN chmod +x /init.sh

# Expose php-fpm default port
EXPOSE 9000

ENTRYPOINT ["/init.sh"]