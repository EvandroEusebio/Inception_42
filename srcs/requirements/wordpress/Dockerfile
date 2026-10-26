FROM debian:bookworm



RUN apt-get update && apt-get install -y --no-install-recommends \
    php-fpm \
    php-bcmath \
    php-curl \
    php-imagick \
    php-intl \
    php-mbstring \
    php-mysql \
    php-xml \
    php-zip \
    php-gd \
    wget \
    unzip \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.zip && unzip latest.zip && rm latest.zip

COPY conf/wp-config.php /var/www/html/wordpress/wp-config.php
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp


COPY tools/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

CMD ["script.sh"]