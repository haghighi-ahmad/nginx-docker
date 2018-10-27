FROM ubuntu:18.04

MAINTAINER Ahmad Haghighi "haghighi@fedoraproject.org"

RUN apt-get update
RUN apt-get install -y wget git vim nginx
RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y  tzdata

RUN apt-get install -y php-cli php-common php-mysql  php-curl php-fpm

RUN ln -fs /usr/share/zoneinfo/Asia/Tehran /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get install -y curl lynx
RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php/7.2/fpm/php.ini

COPY nginx-default /etc/nginx/sites-available/default
COPY start.sh /start.sh

COPY index.php /usr/share/nginx/html/index.php

EXPOSE 80

ENTRYPOINT  /start.sh
#ENTRYPOINT  /bin/bash
