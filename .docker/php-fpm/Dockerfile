ARG PHP_VERSION
FROM php:${PHP_VERSION}

RUN apk update && apk add bash \
    && docker-php-ext-install pdo_mysql \
    && apk add --no-cache $PHPIZE_DEPS \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN cp $(find /usr/local/etc/php -name "php.ini-development") /usr/local/etc/php/php.ini && \
    find /usr/local/lib/php -name "xdebug.so" -exec echo 'zend_extension="{}"' >> /usr/local/etc/php/php.ini \;

COPY xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

CMD ["php-fpm"]