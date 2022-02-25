#!/bin/bash

# Php paketleri kuruluyor.
apt-get install -y --allow-change-held-packages \
php7.4 php7.4-bcmath php7.4-bz2 php7.4-cgi php7.4-cli php7.4-common php7.4-curl php7.4-dba php7.4-dev \
php7.4-enchant php7.4-fpm php7.4-gd php7.4-gmp php7.4-imap php7.4-interbase php7.4-intl php7.4-json php7.4-ldap \
php7.4-mbstring php7.4-mysql php7.4-odbc php7.4-opcache php7.4-pgsql php7.4-phpdbg php7.4-pspell php7.4-readline \
php7.4-snmp php7.4-soap php7.4-sqlite3 php7.4-sybase php7.4-tidy php7.4-xdebug php7.4-xml php7.4-xmlrpc php7.4-xsl \
php7.4-zip php7.4-memcached php7.4-redis

# PHP yapılandırılıyor.
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 2048M/g' /etc/php/7.4/fpm/php.ini    # Dosya yükleme limiti değiştiriliyor.
sed -i 's/post_max_size = 8M/post_max_size = 2048M/g' /etc/php/7.4/fpm/php.ini    # Post limiti değiştiriliyor.
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.4/fpm/php.ini    #

sed -i 's/;date.timezone =/date.timezone = Europe\/Istanbul/g' /etc/php/7.4/cli/php.ini    # Zaman dilimi tanımlanıyor.
sed -i 's/;date.timezone =/date.timezone = Europe\/Istanbul/g' /etc/php/7.4/cgi/php.ini    # Zaman dilimi tanımlanıyor.
sed -i 's/;date.timezone =/date.timezone = Europe\/Istanbul/g' /etc/php/7.4/fpm/php.ini    # Zaman dilimi tanımlanıyor.

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

systemctl enable php7.4-fpm
service php7.4-fpm restart