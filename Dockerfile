# Latest Ubuntu LTS
FROM ubuntu:jammy 

# Install packages
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    git \
    git-lfs \
    sudo \
    locales \
    nano \
    vim \
    netcat \
    htop \
    mysql-server \
    php php-mysql php-zip php-json php-mbstring \
    phpmyadmin \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*
    
# Setup locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8

RUN useradd -l -u 33333 -G sudo -md /home/dev -s /bin/bash -p dev dev
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Configure MySQL
RUN mkdir -p /var/run/mysqld /var/log/mysql \
 && chown -R dev:dev /etc/mysql /var/run/mysqld /var/log/mysql /var/lib/mysql /var/lib/mysql-files /var/lib/mysql-keyring /var/lib/mysql-upgrade
COPY config/mysql/mysql.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
COPY config/mysql/client.cnf /etc/mysql/mysql.conf.d/client.cnf

# Configure Apache for phpMyAdmin
COPY config/phpmyadmin/config.inc.php /etc/phpmyadmin/config.inc.php
COPY config/phpmyadmin/config.inc.php /usr/share/phpmyadmin/config.inc.php
RUN cp /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf && a2enconf phpmyadmin

# Copy files from public
RUN rm -rf /var/www/html
COPY public /var/www/html

USER dev
WORKDIR /home/dev
COPY . .

ENTRYPOINT ["./setup/run.sh"]
