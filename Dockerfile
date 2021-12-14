FROM debian:latest
MAINTAINER Frederic Mohr <f.mohr@futrue.com>

## Install base packages
RUN apt-get update && \
    apt-get -yq install \
		apache2 \
		php \
		libapache2-mod-php \
		curl \
		pwgen \
		ca-certificates \
		php-curl \
		php-mysql \
		php-zip \
		php-mcrypt && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archive/*.deb

RUN /usr/sbin/phpenmod mcrypt && a2enmod rewrite && mkdir /bootstrap

ADD 000-default.conf /etc/apache2/sites-available/000-default.conf
ADD start.sh /bootstrap/start.sh
RUN chmod 755 /bootstrap/start.sh && chown -R www-data:www-data /var/www/html

EXPOSE 80
ENTRYPOINT ["/bootstrap/start.sh"]
