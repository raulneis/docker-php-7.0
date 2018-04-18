FROM ubuntu:16.04
MAINTAINER @raulneis <raulneis@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y apache2 \
                       php7.0 \
                       libapache2-mod-php7.0 \
                       php7.0-mbstring \
                       php7.0-mcrypt \
                       php7.0-xml \
                       php7.0-zip \
                       php-xdebug \
                       composer


ADD php.ini-apache /etc/php/7.0/apache2/php.ini
ADD php.ini-cli /etc/php/7.0/cli/php.ini

RUN a2enmod rewrite headers

USER www-data:www-data

RUN mkdir -p /var/www/html
WORKDIR /var/www/html

EXPOSE 80
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
