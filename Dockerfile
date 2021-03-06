FROM phpdockerio/php74-cli

# Install FPM
RUN apt-get update \
    && apt-get -y --no-install-recommends install php7.4-fpm \
        php7.4-mysql php-memcached php7.4-intl php7.4-mbstring php7.4-soap \
        php-imagick php7.4-xml php7.4-curl php7.4-gd php7.4-readline \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

STOPSIGNAL SIGQUIT

# PHP-FPM packages need a nudge to make them docker-friendly
COPY overrides.conf /etc/php/7.4/fpm/pool.d/z-overrides.conf

CMD ["/usr/sbin/php-fpm7.4", "-O" ]

# Open up fcgi port
EXPOSE 8888
