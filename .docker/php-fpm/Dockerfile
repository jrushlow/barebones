ARG PHP_VERSION
FROM php:${PHP_VERSION}

RUN apk update && apk add bash \
    && docker-php-ext-install pdo_mysql \
    && apk add --no-cache $PHPIZE_DEPS \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN echo 'zend_extension="/usr/local/lib/php/extensions/no-debug-non-zts-20180731/xdebug.so"' >> /usr/local/etc/php/php.ini

COPY xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

CMD ["php-fpm"]

EXPOSE 9000 9001