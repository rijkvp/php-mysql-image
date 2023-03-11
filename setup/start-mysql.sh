#!/bin/bash
# Starts the MySQL server
if [ ! -e /var/run/mysqld/mysql-init.lock ]
then
    touch /var/run/mysqld/mysql-init.lock

    # initialize database structures on disk, if needed
    [ ! -d /workspace/mysql ] && mysqld --initialize-insecure

    # launch database, if not running
    [ ! -e /var/run/mysqld/mysqld.pid ] && mysqld --daemonize

    rm /var/run/mysqld/mysql-init.lock
fi

echo "Waiting for MySQL to launch on 3306..."
while ! nc -z localhost 3306; do   
  sleep 0.1
done

# Create 'user' and 'readonly' database users
sudo mysql -u root -e "\
CREATE USER 'user'@'localhost' IDENTIFIED BY 'password'; \
CREATE USER 'readonly'@'localhost' IDENTIFIED BY 'password'; \
GRANT ALL PRIVILEGES ON *.* TO 'user'@'localhost'; \
GRANT SELECT ON *.* TO 'readonly'@'localhost'; \
";
