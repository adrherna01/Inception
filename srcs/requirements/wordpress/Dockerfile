FROM debian:bullseye

# Install dependencies
RUN apt-get update && \
    apt-get install -y php php-fpm php-mysql wget tar less curl mariadb-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create WordPress directory
WORKDIR /var/www/wordpress

# Download WordPress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 && \
    rm latest.tar.gz

# Copy entrypoint script
COPY config/init.sh /init.sh
RUN chmod +x /init.sh

# Expose php-fpm default port
EXPOSE 9000

ENTRYPOINT ["/init.sh"]
CMD ["php-fpm7.4", "-F"]