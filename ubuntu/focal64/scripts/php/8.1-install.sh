#!/bin/bash

sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -y

# Php paketleri kuruluyor.
apt-get install -y --allow-change-held-packages \
php8.1 php8.1-bcmath php8.1-bz2 php8.1-cgi php8.1-cli php8.1-common php8.1-curl php8.1-dba php8.1-dev \
php8.1-enchant php8.1-fpm php8.1-gd php8.1-gmp php8.1-imap php8.1-interbase php8.1-intl php8.1-ldap \
php8.1-mbstring php8.1-mysql php8.1-odbc php8.1-opcache php8.1-pgsql php8.1-phpdbg php8.1-pspell php8.1-readline \
php8.1-snmp php8.1-soap php8.1-sqlite3 php8.1-sybase php8.1-tidy php8.1-xml php8.1-xsl \
php8.1-zip php8.1-dom

# PHP yapılandırılıyor.
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 2048M/g' /etc/php/8.1/fpm/php.ini    # Dosya yükleme limiti değiştiriliyor.
sed -i 's/post_max_size = 8M/post_max_size = 2048M/g' /etc/php/8.1/fpm/php.ini    # Post limiti değiştiriliyor.
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/8.1/fpm/php.ini    #

sed -i 's/;date.timezone =/date.timezone = Europe\/Istanbul/g' /etc/php/8.1/cli/php.ini    # Zaman dilimi tanımlanıyor.
sed -i 's/;date.timezone =/date.timezone = Europe\/Istanbul/g' /etc/php/8.1/cgi/php.ini    # Zaman dilimi tanımlanıyor.
sed -i 's/;date.timezone =/date.timezone = Europe\/Istanbul/g' /etc/php/8.1/fpm/php.ini    # Zaman dilimi tanımlanıyor.

cat >> /etc/php/8.1/mods-available/xdebug.ini << EOF

xdebug.idekey="PHPSTORM"
xdebug.remote_enable=1
xdebug.remote_connect_back=1
xdebug.remote_port=9000
xdebug.max_nesting_level=300
xdebug.scream=0
xdebug.cli_color=1
xdebug.show_local_vars=1

EOF

service php8.1-fpm reload;
