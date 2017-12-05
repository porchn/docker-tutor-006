FROM php:5.6-apache

ENV TZ Asia/Bangkok

RUN echo ${TZ} > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata \
    && echo date.timezone = ${TZ} > /usr/local/etc/php/conf.d/docker-php-ext-timezone.ini

RUN touch /usr/local/etc/php/php.ini \
    && echo "[PHP]" > /usr/local/etc/php/php.ini

RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
    && apt-get clean \
    && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-install mysqli

RUN a2enmod rewrite

VOLUME [ "/var/www/html" ]

COPY ./index.php /var/www/html

EXPOSE 80 443