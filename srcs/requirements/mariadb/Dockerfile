FROM debian:bullseye

# Install MariaD
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean && \
     mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld && \
    rm -rf /var/lib/apt/lists/*

# Copy your custom init script
COPY config/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY config/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose port
EXPOSE 3306

# Use custom entrypoint
ENTRYPOINT ["/entrypoint.sh"]