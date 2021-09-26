#!/bin/bash

# Php paketleri kuruluyor.
apt install php-fpm -y
apt install php-gd -y
apt install php-mbstring -y
apt install php-mcrypt -y
apt install php-soap -y
apt install php-curl -y
apt install php-intl -y
apt install php-memcached -y
apt install php-imap -y
apt install php-sybase -y
apt install php-zip -y
apt install php-bcmatch -y
apt install php-xdebug -y

# PHP yapılandırılıyor.
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 2048M/g' /etc/php/7.4/fpm/php.ini    # Dosya yükleme limiti değiştiriliyor.
sed -i 's/post_max_size = 8M/post_max_size = 2048M/g' /etc/php/7.4/fpm/php.ini    # Post limiti değiştiriliyor.
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.4/fpm/php.ini    #

sed -i 's/;date.timezone =/date.timezone = Europe\/Istanbul/g' /etc/php/7.4/fpm/php.ini    # Zaman dilimi tanımlanıyor.
sed -i 's/;date.timezone =/date.timezone = Europe\/Istanbul/g' /etc/php/7.4/cli/php.ini    # Zaman dilimi tanımlanıyor.

cat >> /etc/php/7.4/mods-available/xdebug.ini << EOF

xdebug.idekey="PHPSTORM"
xdebug.remote_enable=1
xdebug.remote_connect_back=1
xdebug.remote_port=9000
xdebug.max_nesting_level=300
xdebug.scream=0
xdebug.cli_color=1
xdebug.show_local_vars=1

EOF

service php7.4-fpm reload;
