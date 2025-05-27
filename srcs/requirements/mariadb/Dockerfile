FROM debian:bullseye

# Install MariaDB
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy your custom init script
COPY config/init.sh /init.sh
COPY config/entrypoint.sh /entrypoint.sh
RUN chmod +x /init.sh /entrypoint.sh

# Expose port
EXPOSE 3306

# Use custom entrypoint
ENTRYPOINT ["/entrypoint.sh"]