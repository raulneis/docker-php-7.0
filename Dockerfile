FROM ubuntu:16.04
MAINTAINER @raulneis <raulneis@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt update
RUN apt -y upgrade
RUN apt install -y --no-install-recommends apt-utils
RUN apt install -y software-properties-common

RUN apt install -y apache2
RUN apt install -y apache2
RUN apt install -y php7.0
RUN apt install -y libapache2-mod-php7.0
RUN apt install -y php7.0-mbstring
RUN apt install -y php7.0-mcrypt
RUN apt install -y php7.0-xml
RUN apt install -y php7.0-zip
RUN apt install -y php7.0-gd
RUN apt install -y php-xdebug
RUN apt install -y composer
RUN apt install -y git
RUN apt install -y nodejs
RUN apt install -y npm
RUN apt install -y redis-server
RUN npm install -g nodemon

RUN apt clean


ADD php.ini-apache /etc/php/7.0/apache2/php.ini
ADD php.ini-cli /etc/php/7.0/cli/php.ini

RUN a2enmod rewrite headers

RUN mkdir -p /var/www/html
WORKDIR /var/www/html
RUN chown www-data:www-data /var/www -R

env APACHE_RUN_USER    www-data
env APACHE_RUN_GROUP   www-data
env APACHE_PID_FILE    /var/run/apache2.pid
env APACHE_RUN_DIR     /var/run/apache2
env APACHE_LOCK_DIR    /var/lock/apache2
env APACHE_LOG_DIR     /var/log/apache2

EXPOSE 80
CMD apachectl -D FOREGROUND
