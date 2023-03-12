#!/bin/bash
# Starts the MySQL server
sudo service mysql start
echo "Waiting for MySQL to launch on 3306..."
while ! nc -z localhost 3306; do   
  sleep 0.1
done

## Create 'user' and 'readonly' database users
sudo mysql -u root -e "\
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';\
CREATE USER IF NOT EXISTS 'user'@'localhost' IDENTIFIED BY 'password';\
CREATE USER IF NOT EXISTS 'readonly'@'localhost' IDENTIFIED BY 'password';\
GRANT ALL PRIVILEGES ON *.* TO 'user'@'localhost';\
GRANT SELECT ON *.* TO 'readonly'@'localhost';\
";
